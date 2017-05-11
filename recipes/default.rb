#
# Cookbook:: nsp-aws-chef-cookbook
# Recipe:: default
#
################################################################################
# Copyright (c) 2017 McAfee Inc. - All Rights Reserved.
################################################################################

require 'uri'
linuxurl = "https://#{node['nsp']['nsm_ip']}/sdkapi/cloud/cluster/downloadprobeagent?name=#{node['nsp']['cluster_name']}&ostype=linux"
linuxurl = URI.encode(linuxurl)
windowsurl = "https://#{node['nsp']['nsm_ip']}/sdkapi/cloud/cluster/downloadprobeagent?name=#{node['nsp']['cluster_name']}&ostype=windows"
windowsurl = URI.encode(windowsurl)

case node[:platform]
        when "redhat", "centos", "debian", "ubuntu", "suse", "fedora", "amazon"
                package "wget"
                #Download and install probe
                bash "install_probe" do
                        not_if { ::File.exist?('/usr/local/zasa/zasa') }
                        user "root"
                        cwd "/tmp"
                        code <<-EOH
                                mkdir NSPVirtualProbe
                                cd NSPVirtualProbe
                                wget "#{linuxurl}" --no-check-certificate -O NSPVirtualProbe.tar.gz
                                tar -zxvf NSPVirtualProbe.tar.gz
                                ./install-zlink.sh
                                cd ..
                                rm -rf NSPVirtualProbe
                        EOH
                end
                #start the daemon
                service "zasad" do
                        start_command "/etc/init.d/zasad start"
                        stop_command "service zasad stop"
                        status_command "service zasad status"
                        restart_command "service zasad restart"
                        supports [:start, :stop, :status, :restart]
                        #starts the service if it's not running and enables it to start at system boot time
                        action [:enable, :start]
                end
        when "windows"
                #Download and install probe
                powershell_script "install_probe" do
                        not_if { ::File.exist?("C:\\Program Files\\McAfee\\zasa\\zasa.exe") }
                        cwd "C:\\Windows\\Temp"
                        code <<-EOH
                                $url = "#{windowsurl}"
                                $path = "C:\\Windows\\Temp\\NSPVirtualProbe.zip"
                                [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
                                $webClient = new-object System.Net.WebClient
                                $webClient.DownloadFile( $url, $path )
                                [System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem')
                                [System.IO.Compression.ZipFile]::ExtractToDirectory($path, "C:\\Windows\\Temp\\NSPVirtualProbe")
                                cd NSPVirtualProbe
                                powershell -executionpolicy bypass -File config.ps1
                                cd ..
                                Remove-Item NSPVirtualProbe -Force -Recurse
                                Remove-Item NSPVirtualProbe.zip -Force
                        EOH
                        action :run
                end
        else
                Chef::Log.fatal('Operating System not supported for installing NSP Virtual Probe!')
                raise
end

# McAfee Virtual Network Security Platform for Amazon Web Services Chef Cookbook

This chef cookbook installs/configures Network Security Platform Virtual Probes in the Virtual Machines.

## Description

Chef is an orchestration tool for delivering cloud automation and desired state configurations. With the release of Virtual Network Security Platform (vNSP) for Amazon Web Services (AWS), vNSP provides seamless integration with Chef, thereby giving you the ability to provision and deploy Virtual Probes through a single command per cluster. This cookbook installs Network Security Platform Virtual Probes on Debian-based (Debian, Ubuntu) and RHEL-based (RHEL, CentOS, Amazon Linux), Suse Linux and Windows operating systems. This cookbook supports installation through the default recipe where it is required to provide the configuration information through attributes. The cookbook deployment code is applicable per cloud cluster.

## Attributes

The cookbook deployment code is applicable per cloud cluster. The following attributes are configurable in the cookbook’s attributes/default.rb file. The following attributes are configurable

- default['nsp']['nsm_ip'] - Specify NSM IP address here
- default['nsp']['cluster_name'] - Specify cluster name here

## Installation Instruction

- Technical Support recommends you bootstrap nodes to run the default recipe to install Virtual Probes in the Virtual Machines.
- Ensure the virtual machine for which you are running the bootstrap operation is part of the cluster configured in attributes/default.rb file.
- Currently, only installation of the Virtual Probes in virtual machines can be performed through Chef. Do not run this cookbook periodically because vNSP Virtual probe updates will be performed through the Network Security Manager and not through Chef.

## Support

This is a community project developed by contributions from the Network Security Platform team, but there is no official McAfee support for this project.

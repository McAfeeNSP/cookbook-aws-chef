# McAfee Network Security Platform AWS Chef Cookbook

This chef cookbook installs/configures Network Security Platform Virtual Probes in the Virtual Machines.

## Description

This cookbook installs Network Security Platform Virtual Probes on Debian-based (Debian, Ubuntu) and RHEL-based (RHEL, CentOS, Amazon Linux), Suse Linux and Windows operating systems. This cookbook supports installation through the default recipe where it is required to provide the configuration information through attributes. The cookbook deployment code is applicable per cloud cluster.

## Attributes

The cookbook deployment code is applicable per cloud cluster. The following attributes are configurable in the cookbook’s attributes/default.rb file. The following attributes are configurable

- default['nsp']['nsm_ip'] - Specify NSM IP address here
- default['nsp']['cluster_name'] - Specify cluster name here

## Support

This is a community project developed by contributions from the Network Security Platform team, but there is no official McAfee support for this project.


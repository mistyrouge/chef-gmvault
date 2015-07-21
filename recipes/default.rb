#
# Cookbook Name:: gmvault
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


root = "/usr/lib/gmvault"

python_virtualenv root do
  owner "ubuntu"
  group "ubuntu"
  action :create
end

python_pip "gmvault" do
  virtualenv root
  action :install, :upgrade
end

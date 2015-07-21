#
# Cookbook Name:: gmvault
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'python'

root = "/usr/lib/gmvault"

python_virtualenv root do
  owner "root"
  group "root"
  action :create
end

python_pip "gmvault" do
  virtualenv root
  action [:install, :upgrade]
end

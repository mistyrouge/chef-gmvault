#
# Cookbook Name:: gmvault
# Recipe:: default
#
# Do whatever the fuck you want
#

include_recipe 'python'

root = "/usr/local/lib/gmvault"

users_manage "gmvault" do
  action [ :remove, :create ]
end

python_virtualenv root do
  owner "root"
  group "gmvault"
  action :create
end

python_pip "gmvault" do
  virtualenv root
  action [:install, :upgrade]
end

link '/usr/local/bin/gmvault' do
  to "#{root}/bin/gmvault"
end

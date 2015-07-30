#
# Cookbook Name:: gmvault
# Recipe:: default
#
# Do whatever the fuck you want
#

include_recipe 'python'

users_manage "gmvault" do
    action [ :remove, :create ]
end

python_virtualenv node[:gmvault][:install_dir] do
    owner "root"
    group "gmvault"
    action :create
end

python_pip "gmvault" do
    virtualenv node[:gmvault][:install_dir]
    action [:install, :upgrade]
end

link '/usr/local/bin/gmvault' do
    to "#{node[:gmvault][:install_dir]}/bin/gmvault"
end

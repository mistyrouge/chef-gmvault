#
# Cookbook Name:: gmvault
# Recipe:: default
#
# Do whatever the fuck you want
#

include_recipe 'gmvault'

if Chef::Config[:solo] and not chef_solo_search_installed?
    Chef::Log.warn("This recipe uses search. Chef Solo does not support "\
                   "search unless you install the chef-solo-search cookbook.")
else
    search('users', 'groups:gmvault AND email:*') do |user|

        user['username'] ||= user['id']
        dst = node[:gmvault][:email_path]
        cli = "/usr/local/bin/gmvault sync #{user['email']} -d #{dst}"

        cron 'gmvault' do
            action :create
            time :daily
            user user['username']
            mailto user['email']
            command cli
        end

        Chef::Log.warn("You will need to run gmvault manually for the first "\
                       "time to authenticate yourself.\n"\
                       "$ #{cli}")

      end
end

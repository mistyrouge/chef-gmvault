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

        cron 'gmvault' do
            action :create
            minute '45'
            hour '7'
            day '*'
            user user['username']
            mailto user['email']
            command "gmvault sync #{user['id']} -d ~/email"
        end

        Chef::Log.warn("You will need to run gmvault manually for the first "\
                       "time to authenticate yourself.\n"\
                       "$ gmvault sync #{user['id']} -d ~/email")

      end
end

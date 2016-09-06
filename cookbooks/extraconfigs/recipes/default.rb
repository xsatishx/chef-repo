#
# Cookbook Name:: extraconfig
# Recipes:: default
#
# Copyright 2016, HealthSeq Asia Pvt. Ltd.
# Maintainer Satish Balakrishnan <satish@healthseq.com>
#
# All rights reserved - Do Not Redistribute
#

# fasterdata
cookbook_file '/etc/sysctl.d/99-fasterdata.es.net.conf' do
  source '99-fasterdata.es.net.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

# motd
template "/etc/update-motd.d/99-compliance" do
  source "99-compliance.erb"
  mode "544"
  owner "root"
  group "root"
  action :create
end

# nscd
package "nscd" do
  action :install
end

service "nscd" do
  supports :restart => true, :status => true
  action [:enable, :start]
end

%w{ passwd group }.each do |cmd| 
  execute "nscd-clear-#{cmd}" do
    command "/usr/sbin/nscd -i #{cmd}"
    action :nothing
  end
end

# niceties
nicities = { '/etc/vim/vimrc.local' => 'vimrc.local',
             '/etc/skel/.irbrc' => 'irbrc',
             '/etc/profile.d/seteditor.sh' => 'seteditor.sh',
             '/etc/default/sysstat' => 'sysstat.erb',
             '/etc/profile.d/sethistory.sh' => 'sethistory.sh.erb',
             '/etc/sudoers.d/staff_sudoers' => 'staff_sudoers.erb' }

nicities.each do |target, source|
  template target do
   if target =~ /rc/
     mode '644'
   else
     mode '640'
   end
  owner 'root'
  group 'root'
  source source
  action :create
 end
end

# Bash
package "bash" do
  action :install
  action :upgrade
end

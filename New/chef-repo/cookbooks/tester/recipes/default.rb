#
# Cookbook Name:: tester
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


bash 'test' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  ls -lrt
  EOH
end

ruby_block 'reload client config' do
  block do
    system ("ls -lrt")
  end
end

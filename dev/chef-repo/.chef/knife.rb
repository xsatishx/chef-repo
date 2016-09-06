# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "cpph"
client_key               "#{current_dir}/cpph.pem"
chef_server_url          "https://dev-chefserver.cpph-nuh.org/organizations/cpph"
#cookbook_path            ["#{current_dir}/../../../chef-repo"]
cookbook_path             ["#{current_dir}/../../../cookbooks"]
validator_key            "#{current_dir}/ORGANIZATION_validator.pem"	
knife[:editor] = "notepad"

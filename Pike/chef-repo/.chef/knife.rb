# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "admin"
client_key               "#{current_dir}/cpph.pem"
chef_server_url          "https://cpph-ch01-blade02/organizations/cpph-pdc"
#cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_path            ["#{current_dir}/../../../cookbooks"]
validator_key            "#{current_dir}/validator.pem"	
knife[:editor] = "notepad"

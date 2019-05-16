# TODO: Fix make this a config item
Chef::Config['ssl_verify_mode'] = :verify_none

require 'chef/idm/chef/base'
require 'chef/idm/chef/global'
require 'chef/idm/chef/org'

require "chef/idm/version"
require "chef/idm/config"
require "chef/idm/ldap"
require "chef/idm/cheforg"
require 'openssl'
require 'securerandom'

class Chef
  class Idm

    # Caching for Config Object
    def self.config
      @config ||= Chef::Idm::Config.new
    end

    # Caching for ChefOrg objects
    def self.cheforg(orgname)
      @chef_orgs ||= {}
      @chef_orgs[orgname] ||= Chef::Idm::ChefOrg.new(orgname)
    end

    # Caching for Ldap::User objects
    def self.ldap_user(user_dn)
      @ldap_users ||= {}
      @ldap_users[user_dn] ||= Chef::Idm::Ldap::User.new(user_dn)
    end

    # Caching for Ldap::Group objects
    def self.ldap_group(group_dn)
      @ldap_groups ||= {}
      @ldap_groups[group_dn] ||= Chef::Idm::Ldap::Group.new(group_dn)
    end
    
  end
end
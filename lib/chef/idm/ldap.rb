require 'net/ldap'
require 'chef/idm/ldap/group'
require 'chef/idm/ldap/user'

class Chef
  class Idm
    class Ldap

      def self.connection
        @connection ||= Net::LDAP.new(
          :force_no_page => true,
          :host => Chef::Idm.config.ad_fqdn,
          :port => Chef::Idm.config.ad_port,
          :auth => {
            :method => :simple,
            :username => Chef::Idm.config.ad_bind_dn,
            :password => Chef::Idm.config.ad_bind_password,
          }
        )
        @connection.bind
        @connection
      end

      def self.search(attribute, value)
        connection.search(
          :base => Chef::Idm.config.ad_base_dn,
          :filter => Net::LDAP::Filter.eq(attribute, value)
        )
      end
    end
  end
end

require 'json'

class Chef
  class Idm
    class Config

      def initialize
        @@config ||= JSON.parse(File.read(File.expand_path('~/.chef-idm/config.json')))
      end

      def ad_base_dn
        @@config['ad_base_dn']
      end

      def ad_bind_dn
        @@config['ad_bind_dn']
      end

      def ad_bind_password
        @@config['ad_bind_password']
      end

      def ad_fqdn
        @@config['ad_fqdn']
      end

      def ad_port
        @@config['ad_port']
      end

      def chef_user
        @@config['chef_user']
      end

      def chef_pem
        @@config['chef_pem']
      end

      def chef_fqdn
        @@config['chef_fqdn']
      end

      def organizations
        @@config['organizations']
      end

    end

    def self.config
      Chef::Idm::Config.new
    end

  end
end

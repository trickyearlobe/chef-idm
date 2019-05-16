class Chef
  class Idm
    class ChefBase

      OBJECT_NAME_SPEC = /^[\-[:alnum:]_\.]+$/

      def initialize(orgname = nil)
        @orgname = orgname
        if orgname.nil?
          server_url = "https://#{Chef::Idm.config.chef_fqdn}"
        else
          server_url = "https://#{Chef::Idm.config.chef_fqdn}/organizations/#{orgname}"
        end
        @api = ::Chef::ServerAPI.new(
          server_url,
          {
            client_name:          Chef::Idm.config.chef_user,
            signing_key_filename: File.expand_path(Chef::Idm.config.chef_pem)
          }
        )
      end

      def api
        @api
      end

      def valid_object_name?(name)
        if OBJECT_NAME_SPEC.match(name)
          true
        else
          false
        end
      end

    end
  end
end

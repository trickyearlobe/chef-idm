class Chef
  class Idm
  
    class ChefOrg

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

      def user_list
        @users ||= @api.get('/users').map {|u| u['user']['username']}
      end

      def global_user_list
      end

      def new_global_user(cname)
        myuser = {
          name: cname,
          display_name: cname,
          email: "#{cname}@noreply.com",
          first_name: cname,
          last_name: cname,
          middle_name: cname,
          password: SecureRandom.hex,
          "public_key": OpenSSL::PKey::RSA.new(2048).public_key.to_s
        }
      end
    end

  end
end

# TODO: Fix make this a config item
Chef::Config['ssl_verify_mode'] = :verify_none
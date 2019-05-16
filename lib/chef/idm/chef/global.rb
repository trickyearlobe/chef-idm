class Chef
  class Idm
    class ChefGlobal < ::Chef::Idm::ChefBase

      def initialize(orgname = nil)
        super
      end

      def user_list
        api.get('/users').keys
      end

      def user_add(cname)
        unless (user_list.include?(cname)) || !valid_object_name?(cname)
          puts "  creating chef user #{cname}"
          myuser = {
            name: cname,
            display_name: cname,
            email: "#{cname}@noreply.com",
            first_name: cname,
            last_name: cname,
            middle_name: cname,
            password: Chef::Idm.config.chef_default_user_password || SecureRandom.hex,
            "public_key": OpenSSL::PKey::RSA.new(2048).public_key.to_s
          }
          api.post('/users',myuser)
        end
      end
    end

  end
end

class Chef
  class Idm
    class ChefGlobal < ::Chef::Idm::ChefBase

      def initialize(orgname = nil)
        super
      end

      def user_list
        api.get('/users').keys
      end

      def user_add(cname,fname,mname,lname,dname,email,password)
        unless (user_list.include?(cname)) || !valid_object_name?(cname)
          puts "  creating chef user #{cname}"
          myuser = {
            name: cname,
            display_name: dname,
            email: email,
            first_name: fname,
            last_name: lname,
            external_authentication_uid: cname,
            password: password,
            "public_key": OpenSSL::PKey::RSA.new(2048).public_key.to_s
          }
          api.post('/users',myuser)
        end
      end

      def user_update(cname,fname,mname,lname,dname,email)
        if (user_list.include?(cname)) && valid_object_name?(cname)
          puts "  updating chef user #{cname}"
          myuser = {
            name: cname,
            display_name: dname,
            email: email,
            first_name: fname,
            last_name: lname,
            middle_name: mname,
            external_authentication_uid: cname
          }
          api.put("/users/#{cname}",myuser)
        end
      end

    end
  end
end

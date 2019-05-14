class Chef
  class Idm
    class Ldap
      class User

        def self.list
          Chef::Idm::Ldap.search('objectClass','user').map do |user|
            user.samaccountname.first
          end
        end

        def self.find(dname)
          Chef::Idm::Ldap.search('distinguishedname', dname)
        end

        def self.exist?(dname)
          userlist = self.find(dname)
          if userlist.length == 1
            if userlist.first.objectclass.include? "user"
              true
            else
              false
            end
          end
        end


        def self.cname(dname)
          userlist = self.find(dname)
          if userlist.length == 1
            userlist.first.samaccountname.first
          else
            nil
          end
        end

      end
    end
  end
end


      


class Chef
  class Idm
    class Ldap
      class Group

        def self.list
          Chef::Idm::Ldap.search('objectClass','group').map do |group|
            group.samaccountname.first
          end
        end

        def self.find(groupname)
          Chef::Idm::Ldap.search('distinguishedname', groupname)
        end

        def self.exist?(groupname)
          grouplist = self.find(groupname)
          if grouplist.length == 1
            if grouplist.first.objectclass.include? "group"
              true
            else
              false
            end
          end
        end

        def self.members(groupname)
          grouplist = self.find(groupname) 
          if grouplist.length == 1
            if grouplist.first.objectclass.include? "group"
              grouplist.first.member
            else
              nil
            end
          end
        end

        def self.cname(dname)
          grouplist = self.find(dname)
          if grouplist.length == 1
            grouplist.first.samaccountname.first
          else
            nil
          end
        end

      end
    end
  end
end

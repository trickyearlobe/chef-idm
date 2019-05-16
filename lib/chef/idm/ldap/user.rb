class Chef
  class Idm
    class Ldap
      class User < Chef::Idm::Ldap::Entity

        def initialize(dn)
          super(dn,'user')
          if exist?
            @useraccountcontrol = @entity.useraccountcontrol.first.to_i
            if (@useraccountcontrol & 2) == 2
              @disabled = true
            else
              @disabled = false
            end
          end
        end

        def disabled
          @disabled
        end

        def email
          if entity.attribute_names.include? :mail
            entity.mail.first
          else
            "#{cname}@has.no.email.address"
          end
        end

        def first_name
          if entity.attribute_names.include? :givenname
            entity.givenname.first
          else
            cname
          end
        end

        def middle_name
          if entity.attribute_names.include? :middlename
            entity.middlename.first
          else
            ""
          end
        end

        def last_name
          if entity.attribute_names.include? :sn
            entity.sn.first
          else
            cname
          end
        end

        def display_name
          if entity.attribute_names.include? :displayname
            entity.displayname.first
          else
            cname
          end
        end

      end
    end
  end
end

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

      end
    end
  end
end

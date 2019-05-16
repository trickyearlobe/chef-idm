class Chef
  class Idm
    class Ldap
      class Group < Chef::Idm::Ldap::Entity

        attr_reader :member_cnames, :member_dnames

        def initialize(dn)
          super(dn,'group')
          @member_cnames = []
          @member_dnames = []
          if exist?
            if @entity.respond_to? :member
              @entity.member.each do |member_dn|
                if Chef::Idm.ldap_user(member_dn).exist?
                  @member_dnames << Chef::Idm.ldap_user(member_dn).dname
                  @member_cnames << Chef::Idm.ldap_user(member_dn).cname
                end  
              end        
            end
          end
        end

      end
    end
  end
end

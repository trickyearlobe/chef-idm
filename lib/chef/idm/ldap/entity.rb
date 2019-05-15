class Chef
  class Idm
    class Ldap
      class Entity

        def initialize(dn, entity_type)
          @dname = dn
          @cname = nil
          @samaccountname = nil
          @entity_type = entity_type
          @exist = false
          @entity = nil
          @entities = []
          find
        end

        def find
          @entities = Chef::Idm::Ldap.search('distinguishedname', @dname)
          @entity ||= @entities.first if @entities.length == 1
          if (!@entity.nil?) && (@entity.objectClass.include? @entity_type)
            @exist = true
            @cname = @entity.cn.first if @entity.respond_to? :cn
            @samaccountname = entity.samaccountname.first if entity.respond_to? :samaccountname
          end
          @entity
        end

        def exist?
          @exist
        end

        def entity
          @entity
        end

        def cname
          @cname
        end

        def dname
          @dname
        end

      end
    end
  end
end

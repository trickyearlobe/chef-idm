class Chef
  class Idm
    class ChefOrg < ::Chef::Idm::ChefBase

      def initialize(orgname = nil)
        super(orgname)
      end

      def user_list
        api.get('/users').map {|u| u['user']['username']}
      end

      def group_list
        api.get('/groups').keys
      end

      def group_get(groupname)
        api.get("/groups/#{groupname}")
      end

      def group_create(groupname)
        if valid_object_name?(groupname)
          api.post('/groups',{groupname:groupname}) unless group_list.include? groupname
        end
      end

      def group_set_users(groupname, users)
        if valid_object_name?(groupname)
          group_create(groupname)
          existing_group = group_get(groupname)
          new_group = {
            "groupname" => existing_group["groupname"],
            "orgname"   => existing_group["orgname"],
            "actors"    => {
              "users"   => users,
              "clients" => existing_group["clients"],
              "groups"  => existing_group["groups"]
            }
          }
          api.put("groups/#{groupname}", new_group)
        end
      end
    end
  end
end

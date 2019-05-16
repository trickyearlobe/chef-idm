class Chef
  class Idm
    class ChefOrg < ::Chef::Idm::ChefBase

      def initialize(orgname = nil)
        @orgname = orgname
        super(orgname)
      end

      def orgname
        @orgname
      end

      def user_list
        api.get('/users').map {|u| u['user']['username']}
      end

      def user_associated?(username)
        user_list.include?(username)
      end

      def user_associate(username)
        unless user_associated?(username)
          puts "  associating #{username} to #{orgname} chef org"
          api.post('/users',{username:username})
        end
      end

      def user_disassociate(username)
        if user_associated?(username)
          group_remove_user('admins',username) # because can't disassociate admins
          puts "  disassociating #{username} from #{orgname} chef org"
          api.delete("/users/#{username}")
        end
      end

      def user_associations_set(usernames)
        puts "  ensuring associations #{usernames}"
        initial_list = user_list
        # Associate any new users
        usernames.each do |username|
          user_associate(username) unless initial_list.include?(username)
        end
        # Disassociate users who should not be here
        initial_list.each do |username|
          user_disassociate(username) unless usernames.include?(username)
        end
      end

      def group_list
        api.get('/groups').keys
      end

      def group_get(groupname)
        api.get("/groups/#{groupname}")
      end

      def group_create(groupname)
        if (valid_object_name?(groupname)) && (!group_list.include? groupname)
          puts "  creating group #{groupname}"
          api.post('/groups',{groupname:groupname})
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

      def group_remove_user(groupname, username)
        existing_group = group_get(groupname)
        if existing_group['users'].include?(username)
          puts "  removing user #{username} from #{groupname} group"
          existing_group['users'].delete(username)
          new_group = {
            "groupname" => existing_group["groupname"],
            "orgname"   => existing_group["orgname"],
            "actors"    => {
              "users"   => existing_group['users'],
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

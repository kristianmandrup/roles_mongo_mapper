module RoleStrategy::MongoMapper
  module OneRole
    def self.default_role_attribute
      :one_role
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.key :one_role_id, ObjectId 
      base.key :one_role, Role
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end       

      def role_id_attribute
        "#{role_attribute}_id".to_sym
      end       
               
      def in_role(role_name)  
        begin
          role = Role.find_role(role_name)
          all(role_id_attribute => role.id)
        rescue
          return []
        end
      end

      def in_roles(*role_names)
        begin
          role_ids = Role.find_roles(role_names)
          my_id = send(role_attribute).id
          all(role_id_attribute.in => role_ids)
        rescue 
          return []
        end
      end  
    end

    module Implementation
      def role_id_attribute
        "#{role_attribute}_id".to_sym
      end       
            
      # assign roles
      def roles=(*roles)      
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        first_role = roles.flatten.first
        role_relation = role_class.find_role(first_role)
        if role_relation
          self.send("#{role_attribute}=", role_relation)
          self.send("#{role_id_attribute}=", role_relation.id)
          self.save
        end
      end
      alias_method :role=, :roles=
      
      # query assigned roles
      def roles
        [self.send(role_attribute).name.to_sym]
      end
      alias_method :roles_list, :roles
            
    end

    extend Roles::Generic::User::Configuration
    configure :num => :single, :type => :role_class
  end  
end

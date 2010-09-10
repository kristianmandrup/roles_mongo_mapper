module RoleStrategy::MongoMapper
  module ManyRoles
    def self.default_role_attribute
      :many_roles
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.key :many_roles_ids, Array, :typecast => 'ObjectId'
      base.many :many_roles, class_name: 'Role', :in => :many_roles_ids 
      base.ensure_index :many_role_ids     
    end

    module ClassMethods  
      def role_attribute
        strategy_class.roles_attribute_name
      end       

      def role_id_attribute
        "#{role_attribute}_ids".to_sym
      end       
        
      def in_role(role_name)
        role = Role.find_role(role_name)
        res = all(role_id_attribute => role.id)        
      end

      def in_roles(*role_names)                          
        role_ids = Role.find_roles(role_names).map{|role| role.id}
        all(role_id_attribute.in => role_ids)
      end
    end
    
    module Implementation
      def role_id_attribute
        "#{role_attribute}_ids".to_sym
      end
      
      # assign roles
      def roles=(*role_names)  
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        role_relations = role_class.find_roles(*role_names) 
        self.send("#{role_attribute}=", role_relations)
        save
      end

      def add_roles(*role_names)  
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        role_relations = role_class.find_roles(*role_names)
        self.send(role_attribute) << role_relations
        save
      end

      # query assigned roles
      def roles
        self.send(role_attribute)
      end

      def roles_list     
        [roles].flatten.map{|r| r.name }.compact.to_symbols
      end
    end 
    
    extend Roles::Generic::User::Configuration
    configure :type => :role_class     
  end
end


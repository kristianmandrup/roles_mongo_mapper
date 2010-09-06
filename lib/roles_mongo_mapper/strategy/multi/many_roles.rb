module RoleStrategy::MongoMapper
  module ManyRoles
    def self.default_role_attribute
      :many_roles
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.key :many_roles, Array, :index => true, :typecast => 'ObjectId'
      base.many :roles, :in => :many_roles      
    end

    module ClassMethods  
      def role_attribute
        strategy_class.roles_attribute_name
      end       
        
      def in_role(role_name)                          
        role = Role.where(:name => role_name).first
        all(role_attribute => role.id)
      end

      def in_roles(*roles)                          
        role_ids = Role.where(:name => roles.flatten).map{|role| role.id}
        where(role_attribute => role_ids)
      end
    end
    
    module Implementation
      def role_attribute
        strategy_class.roles_attribute_name
      end 
      
      # assign roles
      def roles=(*roles)  
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        role_relations = role_class.find_roles(*roles) 
        self.send("#{role_attribute}=", role_relations)
        save
      end

      def add_roles(*roles)  
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        role_relations = role_class.find_roles(*roles)
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


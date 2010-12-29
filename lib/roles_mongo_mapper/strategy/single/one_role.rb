require 'roles_mongo_mapper/strategy/single'

module RoleStrategy::MongoMapper
  module OneRole
    def self.default_role_attribute
      :one_role
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      # base.key :one_role_id, ObjectId 
      # base.key :one_role, Role
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end       

      def role_id_attribute
        "#{role_attribute}_id".to_sym
      end       
               
      def in_role(role_name)  
        in_any_role(role_name)
      end

      def in_any_role(*role_names)
        begin
          role_ids = Role.find_roles(role_names).map(&:id)
          all("#{role_attribute}._id" => role_ids)
          # all(role_id_attribute.in => role_ids)
        rescue 
          return []
        end
      end  
    end

    module Implementation
      include Roles::MongoMapper::Strategy::Single

      def add_roles *role_names
        new_roles = select_valid_roles(role_names) 
        the_role = new_roles.first if !new_roles.empty?
        set_role new_role(the_role)
      end

      def set_role role
        raise ArgumentError, "#set_role only takes a single role as argument, not #{role}" if role.kind_of?(Array)
        the_role = new_role(role)
        self.send("#{role_attribute}=", the_role)
        # self.one_role_id = the_role.id
      end
            
      def new_role role
        role_class.find_role(extract_role role)        
      end  
      
      def new_roles *roles
        new_role roles.flatten.first
      end     
      
      def present_roles *roles
        roles.map{|role| extract_role role}
      end                 
      
      def set_empty_role
        self.send("#{role_attribute}=", nil)
      end

      def select_valid_roles *role_names
        role_names = role_names.flat_uniq.select{|role| valid_role? role }
        has_role_class? ? role_class.find_roles(role_names).to_a : role_names
      end
    end

    extend Roles::Generic::User::Configuration
    configure :num => :single, :type => :role_class
  end  
end

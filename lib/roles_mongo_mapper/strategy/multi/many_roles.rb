require 'roles_mongo_mapper/strategy/multi'

module RoleStrategy::MongoMapper
  module ManyRoles
    def self.default_role_attribute
      :many_roles
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.key :many_roles_ids, Array, :typecast => 'ObjectId'
      base.many :many_roles, :class_name => 'Role', :in => :many_roles_ids 
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

      def in_any_role(*role_names)                          
        role_ids = Role.find_roles(role_names).map{|role| role.id}
        all(role_id_attribute.in => role_ids)
      end
    end
    
    module Implementation 
      include Roles::MongoMapper::Strategy::Multi

      def has_roles?(*roles_names)
        compare_roles = extract_roles(roles_names.flat_uniq)
        (roles_list & compare_roles).not.empty?      
      end

      def get_roles
        self.send(role_attribute)
      end      

      def roles
        get_roles.to_a.map do |role|
          role.respond_to?(:sym) ? role.to_sym : role
        end
      end

      def roles_list
        my_roles = [roles].flat_uniq
        return [] if my_roles.empty?
        has_role_class? ? my_roles.map{|r| r.name.to_sym } : my_roles          
      end
        
      # assign multiple roles
      def roles=(*role_names)
        role_names = role_names.flat_uniq
        role_names = extract_roles(role_names)
        return nil if role_names.empty?
        valids = role_class.find_roles(role_names).to_a
        vrs = select_valid_roles role_names
        set_roles(vrs)
      end

      def new_roles *role_names
        role_class.find_roles(extract_roles role_names)
      end

      def present_roles roles_names
        roles_names.to_a.map{|role| role.name.to_s.to_sym}
      end

      def set_empty_roles
        self.send("#{role_attribute}=", [])
      end      
      # def role_id_attribute
      #   "#{role_attribute}_ids".to_sym
      # end
      # 
      # # assign roles
      # def roles=(*_roles)  
      #   _roles = get_roles(_roles)
      #   return nil if _roles.none?                
      # 
      #   role_relations = role_class.find_roles(_roles) 
      #   self.send("#{role_attribute}=", role_relations)
      #   save
      # end
      # 
      # def add_roles(*role_names)  
      #   raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
      #   role_relations = role_class.find_roles(*role_names)
      #   self.send(role_attribute) << role_relations
      #   save
      # end
      # 
      # # query assigned roles
      # def roles
      #   self.send(role_attribute)
      # end
      # 
      # def roles_list     
      #   [roles].flatten.map{|r| r.name }.compact.to_symbols
      # end 
    end 
    
    extend Roles::Generic::User::Configuration
    configure :type => :role_class     
  end
end


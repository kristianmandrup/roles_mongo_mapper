module RoleStrategy::MongoMapper
  module AdminFlag
    
    def self.default_role_attribute
      :admin_flag
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end
           
      def in_role(role_name) 
        case role_name.downcase.to_sym
        when :admin
          where(role_attribute => true)
        else
          where(role_attribute => false)
        end          
      end
    end

    module Implementation          
      # assign roles
      def roles=(*new_roles)                                 
        first_role = new_roles.flatten.first
        if valid_role?(first_role)
          self.send("#{role_attribute}=", new_roles.flatten.first.admin?) 
        else
          raise ArgumentError, "The role #{first_role} is not a valid role"
        end
      end

      # query assigned roles
      def roles
        role = self.send(role_attribute) ? strategy_class.admin_role_key : strategy_class.default_role_key
        [role]
      end
      alias_method :roles_list, :roles

    end # Implementation
    
    extend Roles::Generic::User::Configuration
    configure :num => :single
  end   
end

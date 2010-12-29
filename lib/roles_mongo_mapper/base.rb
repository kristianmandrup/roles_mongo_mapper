module Roles::Base
  def valid_roles_are(*role_list)
    strategy_class.valid_roles = role_list.to_symbols
  end
end

module Roles::MongoMapper  
  def self.included(base) 
    base.extend Roles::Base
    base.extend ClassMethods
    base.orm_name = :mongo_mapper
  end

  module ClassMethods
    
    MAP = {
      :admin_flag   => "key :admin_flag, Boolean",
      
      # :embed_many_roles   => "many :many_roles, :class_name => 'Role'",
      # :embed_one_role     => "one :one_role, :class_name => 'Role'",

      :roles_mask   => "key :roles_mask,    Integer, :default => 0",
      :role_string  => "key :role_string,   String",
      :role_strings => "key :role_strings,  Array",
      :roles_string => "key :roles_string,  String"
    }

    def valid_single_strategies
      [:admin_flag, :one_role, :role_string]
    end

    def valid_multi_strategies
      [:many_roles, :roles_mask, :role_strings]
    end

    def valid_strategies
      valid_single_strategies + valid_multi_strategies
    end
    
    def strategy name, options = {}
      strategy_name = name.to_sym
      raise ArgumentError, "Unknown role strategy #{strategy_name}" if !valid_strategies.include? strategy_name
      use_roles_strategy strategy_name

      set_role_class(strategy_name, options) if strategies_with_role_class.include? strategy_name
      
      if default_options?(options) && MAP[strategy_name]
        instance_eval statement(MAP[strategy_name])
      end       

      # one_role reference
      if strategy_name == :one_role
        key :one_role_id, ObjectId 
        key :one_role, @role_class_name
      end
      
      # many_roles references
      if strategy_name == :many_roles
        instance_eval %{
          key :many_roles_ids, Array, :typecast => 'ObjectId'
          many :many_roles, :class_name => '#{@role_class_name}', :in => :many_roles_ids 
          ensure_index :many_role_ids     
        }
      end

      # case name
      # when :embed_one_role
      #   raise ArgumentError, "#strategy class method must take :role_class option when using an embedded role strategy" if !@role_class_name
      #   @role_class_name.embedded_in :user, :inverse_of => :one_role
      # when :embed_many_roles
      #   raise ArgumentError, "#strategy class method must take :role_class option when using an embedded role strategy" if !@role_class_name
      #   @role_class_name.embedded_in :user, :inverse_of => :many_roles
      # end

      set_role_strategy strategy_name, options
    end    

    private

    def set_role_class strategy_name, options = {}
      @role_class_name = !options.kind_of?(Symbol) ? get_role_class(strategy_name, options) : default_role_class(strategy_name)
    end

    def default_options? options = {}
      return true if options == :default                           
      if options.kind_of? Hash
        return true # if options[:config] == :default || options == {} 
      end
      false
    end

    def statement code_str
      code_str.gsub /Role/, @role_class_name.to_s
    end

    def default_role_class strategy_name
      if defined? ::Role
        require "roles_mongo_mapper/role_class"
        return ::Role 
      end
      raise "Default Role class not defined"
    end

    def strategies_with_role_class
      # :embed_one_role, :embed_many_roles
      [:one_role, :many_roles]
    end 

    def get_role_class strategy_name, options
      options[:role_class] ? options[:role_class].to_s.camelize.constantize : default_role_class(strategy_name)
    end      
  end
end

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
      # :many_roles   => "references_many :many_roles, :stored_as => :array, :class_name => 'Role', :default => []",
      # :one_role     => "references_one :one_role, :class_name => 'Role'",

      # :embed_many_roles   => "many :many_roles, :class_name => 'Role'",
      # :embed_one_role     => "one :one_role, :class_name => 'Role'",

      :roles_mask   => "key :roles_mask,    Integer, :default => 0",
      :role_string  => "key :role_string,   String",
      :role_strings => "key :role_strings,  Array",
      :roles_string => "key :roles_string,  String"
    }
    
    def strategy name, options = {}
      if (options == :default || options[:config] == :default) && MAP[name]
        instance_eval MAP[name] 
      end

      if !options.kind_of? Symbol
        role_class = options[:role_class] ? options[:role_class].to_s.camelize.constantize : (Role if defined? Role)
      end

      # case name
      # when :embed_one_role
      #   raise ArgumentError, "#strategy class method must take :role_class option when using an embedded role strategy" if !role_class
      #   role_class.embedded_in :user, :inverse_of => :one_role
      # when :embed_many_roles
      #   raise ArgumentError, "#strategy class method must take :role_class option when using an embedded role strategy" if !role_class
      #   role_class.embedded_in :user, :inverse_of => :many_roles
      # end
      
      set_role_strategy name, options
    end    
  end
end

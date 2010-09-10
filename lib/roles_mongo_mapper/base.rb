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
      :roles_mask   => "key :roles_mask,    Integer, :default => 1",
      :role_string  => "key :role_string,   String",
      :role_strings => "key :role_strings,  Array",
      :roles_string => "key :roles_string,  String"
    }
    
    def strategy name, options = nil
      if options == :default && MAP[name]
        instance_eval MAP[name] 
      end

      role_strategy name, options
    end    
  end
end

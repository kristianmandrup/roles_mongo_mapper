module Roles::Base
  def valid_roles_are(*role_list)
    strategy_class.valid_roles = role_list.to_symbols
    if role_class_name
      role_list.each do |name|
        role_class_name.create(:name => name.to_s)
      end
    end
  end
end

class Role
  include MongoMapper::Document
  key :name, String

  scope :by_name,  lambda { |name| where(:name => name.to_s) }
  scope :by_names,  lambda { |*names| where(:name => names.to_strings) }

  class << self
    def find_roles(*role_names)  
      role_names.flatten!
      by_names(role_names).all
      # where(:name => role_names.to_strings).all 
    end

    def find_role role_name
      raise ArgumentError, "#find_role takes a single role name as argument, not: #{role_name.inspect}" if !role_name.kind_of_label?
      by_name(role_name).first
    end
  end
end  

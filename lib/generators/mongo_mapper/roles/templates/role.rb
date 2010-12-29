class <%= role_class %>
  include MongoMapper::Document
  key :name, String

  validates_uniqueness_of :name

  scope :by_name,  lambda { |name| where(:name => name.to_s) }
  scope :by_names,  lambda { |*names| where(:name => names.to_strings) }
  
  extend RoleClass::ClassMethods
end  

require 'sugar-high/module'

module Roles
  modules :mongo_mapper do
    nested_modules :user, :role
  end
  modules :base, :strategy
end   

module RoleStrategy
  modules :mongo_mapper
end
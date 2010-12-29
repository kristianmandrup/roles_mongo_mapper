require 'spec_helper'

class Role
end

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :one_role
  valid_roles_are :admin, :guest  

  key :name, :type => String  
end

def api_name
  :one_role
end

load 'roles_mongo_mapper/strategy/api_examples.rb'


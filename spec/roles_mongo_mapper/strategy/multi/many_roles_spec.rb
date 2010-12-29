require 'spec_helper'

class Role
end

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :many_roles
  valid_roles_are :admin, :guest, :user  

  key :name, :type => String  
end

def api_name
  :many_roles
end

load 'roles_mongo_mapper/strategy/api_examples.rb'

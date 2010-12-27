require 'spec_helper'
class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :role_string
  valid_roles_are :admin, :guest  

  key :name, :type => String  
end

def api_name
  :role_string
end

load 'roles_mongo_mapper/strategy/api_examples.rb'


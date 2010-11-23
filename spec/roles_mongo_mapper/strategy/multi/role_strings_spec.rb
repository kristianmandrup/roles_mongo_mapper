require 'spec_helper'
use_roles_strategy :role_strings

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :role_strings, :default
  valid_roles_are :admin, :guest, :user  

  key :name, :type => String  
end

def api_name
  :role_strings
end

load 'roles_mongo_mapper/strategy/api_examples.rb'


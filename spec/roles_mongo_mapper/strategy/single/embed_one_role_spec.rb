require 'spec_helper'
use_roles_strategy :embed_one_role

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :embed_one_role, :role_class => :role, :config => :default
  role_class :role  
  valid_roles_are :admin, :guest  

  key :name, :type => String  
end

def api_name
  :embed_one_role
end

load 'roles_mongo_mapper/strategy/api_examples.rb'

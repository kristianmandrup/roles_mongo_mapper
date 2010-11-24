require 'spec_helper'
use_roles_strategy :embed_many_roles

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :embed_many_roles, :role_class => :role, :config => :default
  role_class :role  
  valid_roles_are :admin, :guest, :user  

  key :name, :type => String  
end

def api_name
  :embed_many_roles
end

load 'roles_mongo_mapper/strategy/api_examples.rb'

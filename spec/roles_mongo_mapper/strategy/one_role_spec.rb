require 'spec_helper'
use_roles_strategy :one_role

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
   
  strategy :one_role, :default
  role_class :role  
    
  key :name, String  
end

describe "Roles for Mongoid: :one_role strategy" do
  require "roles_mongo_mapper/user_setup"
  require "roles_generic/rspec/api"
end

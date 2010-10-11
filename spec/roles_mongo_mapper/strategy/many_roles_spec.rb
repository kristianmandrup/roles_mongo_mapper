require 'spec_helper' 
use_roles_strategy :many_roles

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :many_roles, :default
  role_class :role

  key :name, String 
end

describe "Roles for Mongoid: :many_roles strategy" do
  require "roles_mongo_mapper/user_setup"
  require "roles_generic/rspec/api"
end

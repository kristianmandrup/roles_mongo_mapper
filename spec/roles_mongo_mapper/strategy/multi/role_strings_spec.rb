require 'spec_helper'
use_roles_strategy :role_strings

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :role_strings, :default
  valid_roles_are :admin, :guest   

  key :name, String
end

describe "Roles for Mongoid: :role_strings strategy" do
  require "roles_mongo_mapper/user_setup"
  require "roles_generic/rspec/api"
end

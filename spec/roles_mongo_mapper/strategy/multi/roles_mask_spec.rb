require 'spec_helper'
use_roles_strategy :roles_mask

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :roles_mask, :default
  valid_roles_are :admin, :guest

  key :name, String
end

describe "Roles for Mongoid: :roles_mask strategy" do
  require "roles_mongo_mapper/user_setup"
  require "roles_generic/rspec/api"
end

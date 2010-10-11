require 'spec_helper'
use_roles_strategy :admin_flag

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :admin_flag, :default
  valid_roles_are :admin, :guest  

  key :name, String  
end

describe "Roles for Mongoid: :admin_flag strategy" do
  require "roles_mongo_mapper/user_setup"
  require "roles_generic/rspec/api"
end

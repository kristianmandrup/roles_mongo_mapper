require 'spec_helper'
use_roles_strategy :admin_flag

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :admin_flag, :default
  valid_roles_are :admin, :guest  

  key :name, :type => String  
end

def api_name
  :admin_flag
end

load 'roles_mongo_mapper/strategy/api_examples.rb'

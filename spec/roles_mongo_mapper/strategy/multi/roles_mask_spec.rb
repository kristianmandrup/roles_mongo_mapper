require 'spec_helper'
use_roles_strategy :roles_mask

class User 
  include MongoMapper::Document  
  include Roles::MongoMapper 
  
  strategy :roles_mask, :default
  valid_roles_are :admin, :guest, :user  

  key :name, :type => String  
end

def api_name
  :roles_mask
end

load 'roles_mongo_mapper/strategy/api_examples.rb'

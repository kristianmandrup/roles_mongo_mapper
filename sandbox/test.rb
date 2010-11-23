require 'mongo_mapper'
                 
MongoMapper.database = 'roles_for_mm'

class Role    
  include MongoMapper::Document
  key :name, String
end

class User    
  include MongoMapper::Document

  key :name, String
  key :one_role, ::Role
end

role = Role.create(:name => 'admin')
user = User.create(:name => 'Kristian')
user.one_role = role
user.save

puts User.first.id                
puts Role.first.id

u = User.where("role._id" => Role.first.id).first
puts u.inspect




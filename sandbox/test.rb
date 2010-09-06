require 'mongo_mapper'
                 
MongoMapper.database = 'roles_for_mm'

class User    
  include MongoMapper::Document

  key :name, String
end

User.create(:name => 'Kristian').save

puts User.first.id.inspect

u = User.where(:'_id' => User.first.id).first
puts u.inspect




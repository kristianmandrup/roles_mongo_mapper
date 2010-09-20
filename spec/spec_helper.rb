require 'rspec/core'
require 'roles_mongo_mapper'
                 
MongoMapper.database = 'roles_mongo_mapper'

module Database
  def self.teardown
    # MongoMapper.database.collections.each {|collection| collection.drop }    
    MongoMapper.database.collections.each do |coll|
      coll.drop unless coll.name =~ /(.*\.)?system\..*/
    end    
  end
end

RSpec.configure do |config|
  config.mock_with :mocha
  config.before do
    Database.teardown
  end
  
  config.after do
    Database.teardown
  end
  
end



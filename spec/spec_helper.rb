require 'rspec'
require 'rspec/autorun'
require 'mongo_mapper'
require 'roles_for_mm'
                 
MongoMapper.database = 'roles_for_mm'

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
end



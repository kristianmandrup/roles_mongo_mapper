require 'rspec'
require 'rspec/autorun'     
require 'rails3_artifactor'
require 'generator-spec'
require 'roles_generic'

RSpec::Generator.configure do |config|
  config.debug = false
  config.remove_temp_dir = true # false
  config.default_rails_root(__FILE__) 
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  
end
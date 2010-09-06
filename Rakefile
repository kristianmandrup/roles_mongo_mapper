begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "roles_mongo_mapper"
    gem.summary = %Q{Implementation of Roles generic API for MongoMapper}
    gem.description = %Q{Makes it easy to set a role strategy on your User model in MongoMapper}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/roles_mongo_mapper"
    gem.authors = ["Kristian Mandrup"]

    gem.add_development_dependency "rspec", ">= 2.0.0.beta.19"

    gem.add_dependency "mongo_mapper",      '~> 0.8.2'
    gem.add_dependency "activesupport",     '~> 3.0.0'    
    gem.add_dependency "require_all",       '~> 1.1.0' 
    gem.add_dependency "sugar-high",        '~> 0.2.3'        
    gem.add_dependency "roles_generic",     '~> 0.2.2'        

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


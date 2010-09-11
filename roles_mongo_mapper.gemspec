# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{roles_mongo_mapper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-09-11}
  s.description = %q{Makes it easy to set a role strategy on your User model in MongoMapper}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/generators/mongo_mapper/roles/roles_generator.rb",
     "lib/roles_mongo_mapper.rb",
     "lib/roles_mongo_mapper/base.rb",
     "lib/roles_mongo_mapper/namespaces.rb",
     "lib/roles_mongo_mapper/role.rb",
     "lib/roles_mongo_mapper/strategy.rb",
     "lib/roles_mongo_mapper/strategy/multi/many_roles.rb",
     "lib/roles_mongo_mapper/strategy/multi/role_strings.rb",
     "lib/roles_mongo_mapper/strategy/multi/roles_mask.rb",
     "lib/roles_mongo_mapper/strategy/single/admin_flag.rb",
     "lib/roles_mongo_mapper/strategy/single/one_role.rb",
     "lib/roles_mongo_mapper/strategy/single/role_string.rb",
     "logging.log",
     "sandbox/test.rb",
     "spec/generator_spec_helper.rb",
     "spec/roles_mongo_mapper/generators/roles_generator_spec.rb",
     "spec/roles_mongo_mapper/strategy/admin_flag_spec.rb",
     "spec/roles_mongo_mapper/strategy/many_roles_spec.rb",
     "spec/roles_mongo_mapper/strategy/one_role_spec.rb",
     "spec/roles_mongo_mapper/strategy/role_string_spec.rb",
     "spec/roles_mongo_mapper/strategy/role_strings_spec.rb",
     "spec/roles_mongo_mapper/strategy/roles_mask_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/roles_mongo_mapper}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Implementation of Roles generic API for MongoMapper}
  s.test_files = [
    "spec/generator_spec_helper.rb",
     "spec/roles_mongo_mapper/generators/roles_generator_spec.rb",
     "spec/roles_mongo_mapper/strategy/admin_flag_spec.rb",
     "spec/roles_mongo_mapper/strategy/many_roles_spec.rb",
     "spec/roles_mongo_mapper/strategy/one_role_spec.rb",
     "spec/roles_mongo_mapper/strategy/role_string_spec.rb",
     "spec/roles_mongo_mapper/strategy/role_strings_spec.rb",
     "spec/roles_mongo_mapper/strategy/roles_mask_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_runtime_dependency(%q<mongo_mapper>, ["~> 0.8.4"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<sugar-high>, ["~> 0.2.3"])
      s.add_runtime_dependency(%q<roles_generic>, ["~> 0.2.2"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_dependency(%q<mongo_mapper>, ["~> 0.8.4"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_dependency(%q<sugar-high>, ["~> 0.2.3"])
      s.add_dependency(%q<roles_generic>, ["~> 0.2.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
    s.add_dependency(%q<mongo_mapper>, ["~> 0.8.4"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<require_all>, ["~> 1.1.0"])
    s.add_dependency(%q<sugar-high>, ["~> 0.2.3"])
    s.add_dependency(%q<roles_generic>, ["~> 0.2.2"])
  end
end


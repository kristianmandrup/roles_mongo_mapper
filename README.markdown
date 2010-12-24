# Roles for Mongo Mapper

A Mongo Mapper implementation of [Roles Generic](http://github.com/kristianmandrup/roles_generic)
See the Roles [wiki](http://github.com/kristianmandrup/roles_generic/wiki) for an overview of the API and how to use it.

## Role strategies

Role strategies implemented:

Inline attribute on User

* admin_flag
* roles_mask
* role_string
* role_strings

Reference to Role

* many_roles
* one_role

*Update Dec 24, 2010*

Please join in the effort to implement and add these strategies to the mix. So far they have been implemented successfully for Mongoid.

Embedded role

* embed_one_role
* embed_many_roles

## Install as system gem

<code>gem install roles_mongo_mapper</code>

## Install in Rails app

Insert in Gemfile:

<code>gem 'roles_mongo_mapper'</code>

Run <code>$ bundle install</code> from terminal

Alternatively install using [Cream](http://github.com/kristianmandrup/cream)

## Rails generator

The library comes with a Rails 3 generator that lets you populate a user model with a role strategy of your choice. 

Apply :admin_flag Role strategy to User model using default roles :admin and :guest (default)

<code>$ rails g mongo_mapper:roles User --strategy admin_flag</code>

Apply :admin_flag Role strategy to User model using default roles and extra role :author

<code>$ rails g mongo_mapper:roles_migration User --strategy admin_flag --roles author</code>

Apply :one_role Role strategy to User model without default roles, only with roles :user, :special and :editor

<code>$ rails g mongo_mapper:roles_migration User --strategy one_role --roles user special editor --no-default-roles</code>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.

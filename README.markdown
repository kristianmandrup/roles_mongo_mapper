# Roles for Mongo Mapper

A *Mongo Mapper* implementation of [roles generic](http://github.com/kristianmandrup/roles_generic)

## Intro

Implements the [roles generic](http://github.com/kristianmandrup/roles_generic) Roles API

Generic Role strategies implemented:

* admin_flag
* many_roles
* one_role
* roles_mask
* role_string
* role_strings

*Update Nov 24, 2010*
Version 0.3.1 and up is a major refactoring to support Roles Generic 0.3 and above with a new and improved architecture and testing framework. 
Since 0.3.2 development of some basic infrastructure to support embedded role strategies in the future has been initiated.

* embed_one_role
* embed_many_roles

Please join in the effort to implement and add these strategies to the mix.

## Install

<code>gem install roles_mongo_mapper</code>

## Rails generator

The library comes with a Rails 3 generator that lets you populate a user model with a role strategy of your choice. 

The following role strategies are included by default. Add your own by adding extra files inside the strategy folder, one file for each role strategy is recommended.

* admin_flag
* many_roles
* one_role
* roles_mask
* role_string
* role_strings

*Roles generator*

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

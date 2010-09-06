# Roles for Mongo Mapper

A *Mongo Mapper* implementation of [roles generic](http://github.com/kristianmandrup/roles_generic)

## Intro

Implements the [roles generic](http://github.com/kristianmandrup/roles_generic) Roles API
It also implements the following Role strategies:

* admin_flag
* many_roles
* one_role
* roles_mask
* role_string
* role_strings

## Install

<code>gem install roles_mongo_mapper</code>

## Rails generator

_Note_: Needs some work!

The library comes with a Rails 3 generator that lets you populate a user model with a given role strategy 

Example:

<code>$ rails g mongo_mapper:roles user admin_flag</code>


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

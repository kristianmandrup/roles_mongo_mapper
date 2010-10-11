def after_each
  Database.teardown
end 

def before_each
  User.valid_roles_are :admin, :guest
end

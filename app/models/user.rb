class User < ActiveRecord::Base
  # macro 
  # works in conjunction w/ gem bcrypt and gives us all of those abilities in a secure way that doesn't actually store the plain text password
  has_secure_password
end
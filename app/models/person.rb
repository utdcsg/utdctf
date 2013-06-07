# Stores identity information tied to logins
#
# ==== Important Database Attributes
#
# * +ip+ - A string with the IP address of the login
class Person < ActiveRecord::Base
  has_many :users, :through => :logins
  has_many :logins, :dependent => :destroy
end

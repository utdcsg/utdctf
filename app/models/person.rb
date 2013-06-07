class Person < ActiveRecord::Base
  has_many :users, :through => :logins
  has_many :logins, :dependent => :destroy
end

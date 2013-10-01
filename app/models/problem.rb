# Stores information about a problem and its value
#
# ==== Important Database Attributes
#
# * +title+ - Shows up in the list of problems
# * +description+ - Shows up when a competitor selects a problem. Can contain HTML.
# * +points+ - Value of the problem
# * +flag+ - Solution to the problem
#
# ==== Constraints
# * All database attributes must be present.
class Problem < ActiveRecord::Base
  has_many :users, :through => :solves
  has_many :solves, :dependent => :destroy
  has_many :categories, :through => :challenges
  has_many :challenges, :dependent => :destroy

  validates :points, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :flag, :presence => true
  validate :positive_points

  def positive_points
    points >= 0
  end
  
end

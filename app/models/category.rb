# Stores some information about a competition's category.
#
# ==== Important Database Attributes
#
# * +name+ - Stores the category's name
# * +description+ - An optional description text field
#
# ==== Constraints
# * +name+ is required
class Category < ActiveRecord::Base
  has_many :problems, :through => :challenges
  has_many :challenges, :dependent => :destroy
  belongs_to :competition

  validates :name, :presence => true
  
  def available_problems
    self.problems.order('created_at').select{|p| not p.hidden}
  end
  
  def has_problems
    self.problems.order(:points).select{|p| not p.hidden}.length > 0
  end

end

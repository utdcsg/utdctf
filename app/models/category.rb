class Category < ActiveRecord::Base
  has_many :problems, :through => :challenges
  has_many :challenges, :dependent => :destroy
  belongs_to :competition

  validates :name, :presence => true
end

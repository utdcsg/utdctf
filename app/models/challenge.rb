class Challenge < ActiveRecord::Base
  belongs_to :category
  belongs_to :problem, :dependent => :destroy
end

class News < ActiveRecord::Base
  belongs_to :competition

  validates :title, :presence => true
  validates :content, :presence => true
end

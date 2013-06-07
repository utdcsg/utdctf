# Stores news content for competitions
#
# Note that this functionality has not been implemented into the front end yet.
#
# ==== Important Database Attributes
#
# * +title+ - Stores the title for the new item
# * +content+ - The body of text. Can include HTML.
#
# ==== Constraints
# * +content+ is required
class News < ActiveRecord::Base
  belongs_to :competition

  validates :content, :presence => true
end

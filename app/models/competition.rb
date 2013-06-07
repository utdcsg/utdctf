# The central object for each competition. Stores times basic information.
#
# ==== Important Database Attributes
#
# * +name+ - The title of the competition
# * +start+ - The point at which submissions are accepted.
# * +end+ - The point at which submissions are no longer accepted.
# * +active+ - Whether the competition is allowing submissions.
# * +hidden+ - Whether the competition is shown to visitors.
#
# ==== Constraints
# * All database attributes must be present.
# * The start time must be before the end time
# * No two competitions may have the same name
class Competition < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :news, :dependent => :destroy
  has_many :users, :through => :participations
  has_many :participations, :dependent => :destroy

  before_create :set_start_end

  validates :name, :presence => true, :uniqueness => true
  validates :active, :presence => true
  validates :hidden, :presence => true
  validate :sane_time_period

  # Called before object creation to give some sane defaults for start and end times.
  def set_start_end
    self.start = Time.now
    self.end = Time.now + 2.days
  end

  # Returns true if both times are set and start is before the end
  def sane_time_period
    if self.start and self.end and self.start >= self.end
      errors.add(:start, "is later than end")
    end
  end

  # Checks to see if the competition is accepting submissions
  def open_to_submission
    ts = Time.now
    self.active and ts >= self.start and ts <= self.end
  end

  # Counts the number of problems in all categories
  def problem_count
    self.categories.map {|c| c.problems.length }.reduce(0) {|a,x| a+x } 
  end

  # Returns the problems from all categories concatenated into a list
  def problems
    self.categories.map {|c| c.problems }.flatten
  end

end

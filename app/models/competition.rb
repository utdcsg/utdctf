class Competition < ActiveRecord::Base
  has_many :categories, :dependent => :destroy
  has_many :news, :dependent => :destroy
  has_many :users, :through => :participations
  has_many :participations, :dependent => :destroy

  before_create :set_start_end

  validates :name, :presence => true, :uniqueness => true
  validate :sane_time_period

  def set_start_end
    self.start = Time.now
    self.end = Time.now + 2.days
  end

  def sane_time_period
    if self.start and self.end and self.start >= self.end
      errors.add(:start, "is later than end")
    end
  end

  def open_to_submission
    ts = Time.now
    self.active and ts >= self.start and ts <= self.end
  end

  def problem_count
    self.categories.map {|c| c.problems.length }.reduce(0) {|a,x| a+x } 
  end

  def problems
    self.categories.map {|c| c.problems }.flatten
  end

end

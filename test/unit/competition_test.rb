require 'test_helper'

class CompetitionTest < ActiveSupport::TestCase
  test "should have a name" do
    competition = Competition.new(:start => Time.now, :end => Time.now + 2.days, :active => true, :hidden => false)
    assert !competition.save
  end

  test "should have an active setting" do
    competition = Competition.new(:name => 'Test', :start => Time.now, :end => Time.now + 2.days, :hidden => false)
    assert !competition.save
  end

  test "should have an hidden setting" do
    competition = Competition.new(:name => 'Test', :start => Time.now, :end => Time.now + 2.days, :active => false)
    assert !competition.save
  end

  test "should have a valid time setting" do
    competition = Competition.new(:name => 'Test', :active => true, :hidden => false)
    assert !competition.save  # No times
    competition.start = Time.now
    assert !competition.save  # No end time
    competition.end = Time.now - 2.days
    assert !competition.save  # Start < End
  end

  test "should not clash names" do
    competition1 = Competition.new(:name => 'Test', :start => Time.now, :end => Time.now + 2.days, :active => true, :hidden => false)
    competition2 = Competition.new(:name => 'Test', :start => Time.now, :end => Time.now + 2.days, :active => true, :hidden => false)
    competition1.save
    assert !competition2.save
  end
end

require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  test "should have a point value" do
    problem = Problem.new(:title => 'Test', :description => 'Test', :flag => 'Test')
    assert !problem.save
  end

  test "should have a title" do
    problem = Problem.new(:points => 100, :description => 'Test', :flag => 'Test')
    assert !problem.save
  end

  test "should have a description" do
    problem = Problem.new(:points => 100, :title => 'Test', :flag => 'Test')
    assert !problem.save
  end

  test "should have a flag" do
    problem = Problem.new(:points => 100, :title => 'Test', :description => 'Test')
    assert !problem.save
  end
end

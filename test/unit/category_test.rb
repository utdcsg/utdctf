require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should have a name" do
    category = Category.new(:description => 'Test')
    assert !category.save
  end
end

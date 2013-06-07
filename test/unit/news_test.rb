require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "should have content" do
    news = News.new(:title => 'Empty')
    assert !news.save
  end
end

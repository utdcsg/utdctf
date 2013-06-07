require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without name" do
    user = User.new({:password => 'password', :role => :user}, :as => :admin)
    assert !user.save
  end

  test "should have unique name" do
    user1 = User.new({:name => 'user', :password => 'password', :role => :user}, :as => :admin)
    user2 = User.new({:name => 'user', :password => 'password', :role => :user}, :as => :admin)
    user1.save
    assert !user2.save
  end

  test "should have password" do
    user = User.new({:name => 'user', :role => :user}, :as => :admin)
    assert !user.save
  end

  test "should have unique hashes for same passwords" do
    user1 = User.new({:name => 'user1', :password => 'password', :role => :user}, :as => :admin)
    user2 = User.new({:name => 'user2', :password => 'password', :role => :user}, :as => :admin)
    user1.save
    user2.save
    assert_not_equal user1.hashed_password, user2.hashed_password
  end

  test "should authenticate" do
    user = User.new({:name => 'user', :password => 'password', :role => :user}, :as => :admin)
    user.save
    assert User.authenticate('user', 'password')
    assert !User.authenticate('user', 'password123')
  end

  test "can only be mass assigned role by admin" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) do
      user = User.new({:name => 'user', :password => 'password', :role => :user})
      user.save
    end
    user = User.new({:name => 'user', :password => 'password', :role => :user}, :as => :admin)
    assert user.save
  end

  test "should have a role" do
    user = User.new({:name => 'user', :password => 'password'}, :as => :admin)
    assert !user.save
  end

  test "should only be user or admin" do
    user = User.new({:name => 'user', :password => 'password', :role => :test}, :as => :admin)
    assert !user.save
  end
end

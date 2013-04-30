require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do 
  	assert_nothing_raised do
  	UserFriendship.create user: users(:ken), friend: users(:mika)
   end  	
  end

  test "that creating a friendship based om user id and friend id works" do
  	UserFriendship.create user_id: users(:ken).id, friend_id: users(:ariel).id
  	assert users(:ken).friends.include?(users(:ariel))
  end
end

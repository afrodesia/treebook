require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
	context "#new" do
		context "when not logged in" do
			should "redirect to the login page" do
				get :new
				assert_response :redirect
			end
	    end

	    context "when logged in" do
	    	setup do
	    		sign_in users(:ken)
	    	end

	    	should "get new and return sucess" do
	    		get :new
	    		assert_response :success
	    	end

	    	should "should set a flash error if the friend id params is missing" do
	    		get :new, { }
	    		assert_equal "Friend required", flash[:error]

	    	end

	    	should "display's friend's name" do
	    		get :new, friend_id: users(:ariel)
	    		assert_match /#{users(:ariel).full_name}/, response.body

	    	end

	    	should "assign a new user friendship" do
	    		get :new, friend_id: users(:ariel)
	    		assert assigns(:user_friendship)
	    	end

	    	should "assign a new user friendship to correct friend" do
	    		get :new, friend_id: users(:ariel)
	    		assert_equal users(:ariel), assigns(:user_friendship).friend
	    	end

	    	should "assign a new user friendship to currently logged in user" do
	    		get :new, friend_id: users(:ariel)
	    		assert_equal users(:ken), assigns(:user_friendship).user
	    	end

	    	should "return a 404 status if no friend is found" do
	    		get :new, friend_id: 'invalid'
	    		assert_response :not_found
	        end

	        should "ask if you really want to friend this user" do
	        	get :new, friend_id: users(:ken)
	        	assert_match /Do you really want to friend #{users(:ken).full_name}?/, response.body
	        end
	    end		
	end   
end

require 'rails_helper'

RSpec.describe DevicesController, :type => :controller do
	before(:each) do
		@user = 		FactoryGirl.create(:user)
		@user_other = 		FactoryGirl.create(:user)
		@device1 = 	FactoryGirl.create(:device, user: @user)
		@device2 = 	FactoryGirl.create(:device, user: @user)
		@device3 = 	FactoryGirl.create(:device, user: @user_other)
	end

	it "should display the device index page for logged-in users" do
		sign_in @user
		get :index
    expect(response).to be_success
	end

	describe "when user1 is logged-in" do
		it "should display all user devices" do
			sign_in @user
			get :index
	    expect(assigns(:devices)).to match_array([@device1, @device2])
		end

		it "should delete its own devices" do
			sign_in @user
			expect{
				delete :destroy, id: @device1.id
			}.to change(Device,:count).by(-1)
		end

		#New issue in the BugTracker into the GitHub
		it "should not delete otehr people devices" do
			sign_in @user
			expect{
				delete :destroy, id: @device3.id
			}.not_to change(Device,:count)
		end
	end
end

require 'rails_helper'

RSpec.describe User, :type => :model do
  it "should create user" do
  	user=FactoryGirl.create(:user)
  	expect(User.first).to eq(user)
  end
end

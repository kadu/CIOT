require 'rails_helper'

RSpec.describe User, :type => :model do
  it "should create user" do
    user=FactoryGirl.create(:user)
    expect(User.first).to eq(user)
  end

  it "should have a token" do
    pending
    user=FactoryGirl.create(:user)
    expect(user.token).to be_truthy 
  end

  it "should have unique token" do
    pending
    user =FactoryGirl.create(:user)
    user2=FactoryGirl.create(:user)
    expect(user.token != user2.token).to be true 
  end
end

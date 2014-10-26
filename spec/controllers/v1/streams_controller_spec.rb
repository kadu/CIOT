require 'rails_helper'

RSpec.describe V1::StreamsController, :type => :controller do
  describe "as a logged user" do
    before(:each) do
      @user =       FactoryGirl.create(:user)
      sign_in @user

      @user_other = FactoryGirl.create(:user)
      @device =     FactoryGirl.create(:device, user: @user)
    end
    it "should create a stream for a user" do
      request.headers['key'] = @device.key
      request.headers['HTTP_CONTENT_TYPE'] = "application/json"
      post :new, {test: 10}.to_json
      expect(response).to be_success
    end
    it "should not create a stream with a invalid json" do
      request.headers['key'] = @device.key
      request.headers['HTTP_CONTENT_TYPE'] = "application/json"
      post :new, '{test: 10"}'
      json = JSON.parse(response.body).first
      #expectations
      expect(response.status).to eq(200)
      expect(json["status"]).to eql "error"
      expect(json["error_code"]).to eql "001"
    end
  end
end


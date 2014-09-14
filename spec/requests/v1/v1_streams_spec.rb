require 'rails_helper'

RSpec.describe "V1::Streams", :type => :request do
  describe "streams#methods" do
  	before(:each) do
			@user = 			FactoryGirl.create(:user)
			@device = 		FactoryGirl.create(:device, user: @user)

			Timecop.freeze
			@time_stamp = Time.now
			@device.streams.create(body: {"test" => "test1"}.to_json)

			Timecop.travel(Time.now + 1.day)
			@time_stamp1 = Time.now
			@device.streams.create(body: {"test" => "test2"}.to_json)

			Timecop.travel(Time.now + 1.day)
			@time_stamp2 = Time.now
			@device.streams.create(body: {"test" => "test3"}.to_json)

			Timecop.return
		end

		
    it "expect route to define user token" do
      skip
      #status 401 means unauthorized / should match "render status: :unauthorized" in controller
      get "v1/devices/#{@device.id}/streams"
      expect(response.status).to be 401
      get "v1/devices/#{@device.id}/streams/last"
      expect(response.status).to be 401
      get "v1/devices/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}"
      expect(response.status).to be 401
      get "v1/devices/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}/#{@time_stamp2.strftime('%d-%m-%Y')}"
      expect(response.status).to be 401
    end

    it "expect route to return correct json length" do
      get "v1/devices/#{@device.id}/streams?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(3)
    end

    it "expect route to return correct json length" do
      get "v1/devices/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(1)
    end

    it "expect route to return correct json length" do
      get "v1/devices/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}/#{@time_stamp2.strftime('%d-%m-%Y')}?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(3)
    end

    it "should return only the last json" do
      skip
      get "v1/devices/#{@device.id}/streams/last?token=#{@user.token}"
      json = JSON.parse(response.body)
      expect(json.length).to be(1)
      expect(json["body"]).to eql({"test" => "test3"})
    end
  end

end

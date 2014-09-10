require 'rails_helper'

RSpec.describe "V1::Streams", :type => :request do
  describe "streams#list" do
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

		


    it "expect route to return correct json length" do
      get "v1/device/#{@device.id}/streams"
      expect(JSON.parse(response.body).length).to be(3)
    end

    it "expect route to return correct json length" do
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}"
      expect(JSON.parse(response.body).length).to be(1)
    end

    it "expect route to return correct json length" do
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}/#{@time_stamp2.strftime('%d-%m-%Y')}"
      expect(JSON.parse(response.body).length).to be(3)
    end

  end
end

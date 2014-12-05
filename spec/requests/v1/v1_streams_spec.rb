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
      #skip
      #status 401 means unauthorized / should match "render status: :unauthorized" in controller
      get "v1/device/#{@device.id}/streams"
      expect(response.status).to be 401
      get "v1/device/#{@device.id}/streams/last"
      expect(response.status).to be 401
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}"
      expect(response.status).to be 401
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}/#{@time_stamp2.strftime('%d-%m-%Y')}"
      expect(response.status).to be 401
    end

    it "expect route to return correct json length" do
      
      get "v1/device/#{@device.id}/streams?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(3)
    end

    it "expect route to return correct json length" do
      
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(1)
    end

    it "expect route to return correct json length" do
      
      get "v1/device/#{@device.id}/streams/#{@time_stamp.strftime('%d-%m-%Y')}/#{@time_stamp2.strftime('%d-%m-%Y')}?token=#{@user.token}"
      expect(JSON.parse(response.body).length).to be(3)
    end

    it "should return only the last json" do
      get "v1/device/#{@device.id}/streams/last?token=#{@user.token}"
      json = JSON.parse(response.body)
      expect(json.length).to be(1)
      expect(json.first["body"]).to eql({"test" => "test3"})
    end
  end

  describe "mail deliver" do
  	before(:each) do
  		@user = 			FactoryGirl.create(:user)
			@device = 		FactoryGirl.create(:device, user: @user)
			#@rule =				FactoryGirl.create(:trigger, device: @device)
  	end

  	it "when stream rule matches should send an email" do
  		#create a rule
  		@rule =	FactoryGirl.create(:trigger, device: @device, operation: ">", value: "30", property: "degree")
  		#set request header with the key
  		requested = {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json', 'key' => @device.key}
  		#create an device stream so it could match the operation.
  		stream = {"degree" => "31"}.to_json

  		post "/v1/streams/new", stream, requested
  		
  		expect(response.body).to include("status")
  		expect(response.body).to include("success")

  		#check expectations when there is an last
  		email_sent = ActionMailer::Base.deliveries.last
  		expect(email_sent.body).to match /is in true condition./
  		#expect to send email to email recipient
  		expect(email_sent['to'].to_s).to match(@rule.email)
  	end
  	it "when stream rule does not matches shouldn't send any email" do
  		#create a rule
  		@rule =	FactoryGirl.create(:trigger, device: @device, operation: "<", value: "30", property: "degree")
  		#set request header with the key
  		requested = {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json', 'key' => @device.key}
  		#create an device stream so it could match the operation.
  		stream = {"degree" => "31"}.to_json

  		post "/v1/streams/new", stream, requested
  		
  		expect(response.body).to include("status")
  		expect(response.body).to include("success")

  		#check expectations when there is an last
  		email_sent = ActionMailer::Base.deliveries.last
  		#expect to send email to email recipient
  		expect(email_sent['to'].to_s).not_to match(@rule.email)
  	end

  	it "when stream rule matches should send an email" do
  		#create a rule
  		@rule =	FactoryGirl.create(:trigger, device: @device, operation: "==", value: "hot", property: "degree")
  		#set request header with the key
  		requested = {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json', 'key' => @device.key}
  		#create an device stream so it could match the operation.
  		stream = {"degree" => "hot"}.to_json

  		post "/v1/streams/new", stream, requested
  		
  		expect(response.body).to include("status")
  		expect(response.body).to include("success")

  		#check expectations when there is an last
  		email_sent = ActionMailer::Base.deliveries.last
  		#expect to send email to email recipient
  		expect(email_sent['to'].to_s).to match(@rule.email)
  	end
  end
end

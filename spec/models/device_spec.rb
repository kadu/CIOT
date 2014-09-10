require 'rails_helper'

RSpec.describe Device, :type => :model do
  before(:each) do
  	@user = 		FactoryGirl.create(:user)
  	@other_user = 	FactoryGirl.create(:user)
  end

  it "should create an device" do
  	device = Device.new(name: "Device 1", description: "awesome device", user: @user)
  	expect(device.save).to be true
  end

  it "new device should have unique key" do
  	device = Device.create(name: "Device 2", description: "awesome device", user: @user)
  	device2 = Device.create(name: "Device 1", description: "awesome device", user: @user)
  	expect(device.key == device2.key).to be false
  end

  it "should return all devices from user" do
  	device = FactoryGirl.create(:device, user: @user)
  	device2= FactoryGirl.create(:device, user: @other_user)
  	device3= FactoryGirl.create(:device, user: @user)

  	list_of_devices = Device.all_from_user(@user)
  	expect(list_of_devices).to match_array([device, device3])
  end
end

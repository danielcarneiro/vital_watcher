# == Schema Information
#
# Table name: devices
#
#  id          :integer         not null, primary key
#  mac_address :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Device do

	before(:each) do
    @user = Factory(:user)
    @attr = { :mac_address => "00:24:7E:6D:4E:E9" }
  end

  it "should create a new instance given valid attributes" do
    @user.devices.create!(@attr)
  end

  it "should not create with an invalid mac address" do
    Device.new(@attr.merge(:mac_address => "00-af-3e-41-11-13")).should_not be_valid
  end

  describe "user associations" do

    before(:each) do
      @device = @user.devices.create(@attr)
    end

    it "should have a user attribute" do
      @device.should respond_to(:user)
    end

    it "should have the right associated user" do
      @device.user_id.should == @user.id
      @device.user.should == @user
    end
  end
end

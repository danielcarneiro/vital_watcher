# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  login              :string(255)
#  display_name       :string(255)
#  email              :string(255)
#  last_heart_rate    :integer
#  online_status      :boolean
#  last_battery_value :integer
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :login => "teste",
      :display_name => "Daniel Carneiro", 
      :email => "test-email@biodevices.pt",
      :last_heart_rate => 84,
      :online_status => true,
      :last_battery_value => 47,
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a login" do
    no_login_user = User.new(@attr.merge(:login => ""))
    no_login_user.should_not be_valid
  end

  it "should required a display name" do
    no_display_name_user = User.new(@attr.merge(:display_name => ""))
    no_display_name_user.should_not be_valid
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on loign/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:login], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an login with no user" do
        nonexistent_user = User.authenticate("ghost", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on login/password match" do
        matching_user = User.authenticate(@attr[:login], @attr[:password])
        matching_user.should == @user
      end

      it "should return nil on user without password" do
        no_password_user = User.authenticate(@attr[:login], "")
        no_password_user.should be_nil
      end
    end

    describe "update password method" do
      it "should update with a valid password and return true" do
        password = "foobaz"
        @user.update_password(password).should be_true
        User.authenticate(@attr[:login], password).should == @user
      end

      it "should return false for an invalid password" do
        invalid_password = "a"
        @user.update_password(invalid_password).should be_false
        User.authenticate(@attr[:login], invalid_password).should be_nil
      end

    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "devices associations" do
    before(:each) do
      @user = User.create(@attr)
      @device1 = Factory(:device, :user => @user)
      @device2 = Factory(:device, :user => @user, 
                          :mac_address => Factory.next(:mac_address))
    end

    it "should have a devices attribute" do
      @user.should respond_to(:devices)
    end

    it "should have the right devices" do
      @user.devices.should include(@device1, @device2)
    end

    it "should destroy associated devices" do
      @user.destroy
      [@device1, @device2].each do |device|
        Device.find_by_id(device.id).should be_nil
      end
    end

    it "should know if it has a device" do
    end

    describe "has device? method" do
      it "should be true if the passwords match" do
        @user.has_device?(@device1.mac_address).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_device?("11:11:11:11:11:11").should be_false
      end
    end

    describe "find by device method" do
      it "should return the user of the device" do
        User.find_by_device(@device1.mac_address).should == @user
      end

      it "should return nil for an unknown device" do
        User.find_by_device("11:11:11:11:11:11").should be_nil
      end
    end
  end

  describe "heart rate summaries associations" do
    before(:each) do
      @user = User.create(@attr)
      @heart_rate_summary1 = Factory(:heart_rate_summary, :user => @user)
      @heart_rate_summary2 = Factory(:heart_rate_summary, :user => @user)
    end

    it "should have a heart rate summaries attribute" do
      @user.should respond_to(:heart_rate_summaries)
    end

    it "should have the right devices" do
      @user.heart_rate_summaries.should 
        include(@heart_rate_summary1, @heart_rate_summary2)
    end

    it "should destroy associated devices" do
      @user.destroy
      [@heart_rate_summary1, @heart_rate_summary2].each do |heart_rate_summary|
        HeartRateSummary.find_by_id(heart_rate_summary.id).should be_nil
      end
    end

    it "should get the daily heart rate summaries" do
      heart_rate_summary3 = Factory(:heart_rate_summary, :user => @user, :date => Date.yesterday)
      summaries = @user.get_daily_heart_rate_summaries(Date.today)
      summaries.should include(@heart_rate_summary1, @heart_rate_summary2)
      summaries.should_not include(heart_rate_summary3)
    end
  end

  describe "activities associations" do
    before(:each) do
      @user = User.create(@attr)
      @activity1 = Factory(:activity, :user => @user)
      @activity2 = Factory(:activity, :user => @user)
    end

    it "should have a heart rate summaries attribute" do
      @user.should respond_to(:activities)
    end

    it "should have the right devices" do
      @user.activities.should 
        include(@activity1, @activity2)
    end

    it "should destroy associated devices" do
      @user.destroy
      [@activity1, @activity2].each do |activity|
        Activity.find_by_id(activity.id).should be_nil
      end
    end
  end
end

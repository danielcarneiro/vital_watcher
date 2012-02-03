require 'spec_helper'

describe Marshalling do

	before(:each) do
		@attr = {
			:user_id => 1,
			:timestamp => DateTime.now.to_i,
			:request => ["user_data", "battery"]
		}
	end

	# u = { "user_id" => 1, "timestamp" => DateTime.now.to_i, "request" => ["user_data", "battery"]}
	# u2 = { "user_id" => 1, "timestamp" => DateTime.now.to_i, "user_data" => "daniel", "battery" => 87}

	it "should create a valid instance" do
		marshall = Marshalling.new(@attr)
		marshall.should be_valid
	end

	describe "invalid data" do
		it "should require a user id" do
			Marshalling.new(@attr.merge(:user_id => nil)).should_not be_valid
		end

		it "should require a valid user id" do
			Marshalling.new(@attr.merge(:user_id => 0)).should_not be_valid
		end

		it "should require a timestamp" do
			Marshalling.new(@attr.merge(:timestamp => nil)).should_not be_valid
		end

		it "should require a request array" do
			Marshalling.new(@attr.merge(:request => nil)).should_not be_valid
		end
	end
	
	describe "user associations" do
		before(:each) do
			@user = Factory(:user)
      @marshall = Marshalling.new(@attr.merge(:user_id => @user.id))
      @marshall2 = Marshalling.new(@attr.merge(:user => @user))

    end

    it "should have a user attribute" do
      @marshall.should respond_to(:user)
    end

    it "should have the right associated user" do
      @marshall.user_id.should == @user.id
      @marshall.user.should == @user

			@marshall2.user_id.should == @user.id
      @marshall2.user.should == @user      
    end
	end

	describe "parse methods" do
		before(:each) do
			@marshall = Marshalling.new(@attr)
			@marshall.response = {
				"timestamp" => DateTime.now.to_i
			}
		end

		it "should find the right keys" do
			@marshall.parse_request
			@marshall.response.keys.should =~ ["timestamp", "user_data", "battery"]
		end

		it "should parse the user data" do
			@marshall.response.has_key?("user_data").should be_false
			resp = @marshall.parse_user_data
			resp.should == @marshall.user

			@marshall.response.has_key?("user_data").should be_true
			@marshall.parse_user_data.should be_nil
		end

		it "should parse the battery" do
			@marshall.response.has_key?("battery").should be_false
			resp = @marshall.parse_battery
			resp.should == @marshall.user.last_battery_value

			@marshall.response.has_key?("battery").should be_true
			@marshall.parse_battery.should be_nil
		end
	end
end
require 'spec_helper'

describe Marshalling do

	before(:each) do
		@attr = {
			:user_id => 1,
			:timestamp => DateTime.now.to_i,
			:request => []
		}
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
end
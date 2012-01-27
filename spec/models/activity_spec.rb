# == Schema Information
#
# Table name: activities
#
#  id               :integer         not null, primary key
#  activity_type_id :integer
#  user_id          :integer
#  start_date        :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Activity do
  
	before(:each) do
  	@user = Factory(:user)
    @attr = { 
      :start_date => DateTime.now, 
      :activity_type_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
  	@user.activities.create!(@attr)
  end

  describe "validations" do
    it "should require a user id" do
      Activity.new(@attr).should_not be_valid
    end

    it "should require a heart_rate_type id" do
      Activity.new(@attr.merge(:user_id => 1, 
                              :activity_type_id => nil))
        .should_not be_valid
    end

    it "should require a date" do
      Activity.new(@attr.merge(:user_id => 1, 
                              :start_date => nil))
        .should_not be_valid
    end
  end

  describe "handle activity entry by method" do
  	before(:each) do
  		@tag = ActivityType.first.tag
  	end

  	it "should return nil for a non existing activity" do
  		lambda do
  			unkwnow_tag = 0xDC
  			value = Activity.handle_activity_entry(@user, unkwnow_tag)
  			value.should be_nil
			end.should_not change(Device, :count)
  	end

  	it "should create an activity with a valid tag" do
  		lambda do
  			value = Activity.handle_activity_entry(@user, @tag)
			end.should change(Activity, :count).by(1)
  	end
  end

end

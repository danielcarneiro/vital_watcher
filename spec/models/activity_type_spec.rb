# == Schema Information
#
# Table name: activity_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tag        :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe ActivityType do
	before(:each) do
		@attr = {
			:name => "Jumping",
			:tag => 5
		}
	end

	it "should respond to get_by_tag" do
		ActivityType.should respond_to(:find_by_tag)
	end

  describe "validations" do
  	it "should fail to a nil name" do
      nil_name = ActivityType.new(
        @attr.merge(:name => ''))

      nil_name.valid?.should be_false
    end

    it "should fail to a repeated Tag" do
  		activityType = ActivityType.first
  		repeated_tag = ActivityType.new(
  			@attr.merge(:tag => activityType.tag))

			repeated_tag.valid?.should be_false
  	end

  	it "should fail to a Tag greater than 0xFF" do
  		ActivityType.new(@attr.merge(:tag => 256)).valid?.should be_false
  		ActivityType.new(@attr.merge(:tag => 255)).valid?.should be_true
  	end
  end
end

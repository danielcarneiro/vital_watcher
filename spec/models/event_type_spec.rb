# == Schema Information
#
# Table name: event_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  mask       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe EventType do
  before(:each) do
  	@attr = {
  		:name => "Something",
  		:mask => "000001XX"
  	}
  end

  describe "validations" do
  	# it "should fail to a repeated name" do
  	# 	eventType = EventType.first
  	# 	repeated_name = EventType.new(@attr.merge(:name => eventType.name))

  	# 	repeated_name.valid?.should be_false
  	# end


  end
end

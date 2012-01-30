# == Schema Information
#
# Table name: event_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tag        :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe EventType do
  before(:each) do
  	@attr = {
  		:name => "Something",
  		:tag => 0x07
  	}
  end

  describe "validations" do
  	it "should fail to a repeated name" do
  		eventType = EventType.first
  		repeated_name = EventType.new(@attr.merge(:name => eventType.name))

  		repeated_name.valid?.should be_false
  	end
  end
end

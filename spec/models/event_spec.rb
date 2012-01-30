# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  event_type_id :integer
#  user_id       :integer
#  timestamp     :datetime
#  value         :integer
#  handled       :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Event do
  before(:each) do
  	@user = Factory(:user)
  	@attr = {
  		:event_type_id => 1,
  		:timestamp => DateTime.now,
  		:value => 100,
  		:handled => false
  	}
  end

  it "should create a new instance given valid attributes" do
  	@user.events.create!(@attr)
	end


end

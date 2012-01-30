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
    @battery_tag = 0x80
  end

  it "should create a new instance given valid attributes" do
  	@user.events.create!(@attr)
	end

  describe "validations" do
    it "should fail for a nil user" do
      event = Event.new(@attr).should_not be_valid
    end

    it "should require a event_type_id id" do
      Event.new(@attr.merge(:user_id => 1, :event_type_id => nil))
        .should_not be_valid
    end

    it "should require a date" do
      Event.new(@attr.merge(:user_id => 1, :timestamp => nil))
        .should_not be_valid
    end    

    it "should require a handled state" do
      Event.new(@attr.merge(:user_id => 1, :handled => nil))
        .should_not be_valid
    end
  end

  describe "handle_event_entry method" do
    it "should create a new battery entry" do
      lambda do
        value = 42 + @battery_tag
        event = Event.handle_event_entry(@user, value)
        event.value.should == value - @battery_tag
        event.event_type.tag.should == @battery_tag
      end.should change(Event, :count).by(1)
    end

    it "should create a new entry" do
      lambda do
        tag = 0x01
        event = Event.handle_event_entry(@user, tag)
        event.event_type.tag.should == tag
      end.should change(Event, :count).by(1)
    end
  end

  describe "create battery entry method" do
    it "should create a new battery entry" do
      lambda do
        value = 42 + @battery_tag
        event = Event.create_battery_entry(@user, value)
        event.value.should == value - @battery_tag
      end.should change(Event, :count).by(1)
    end

    it "should should not create for a battery over 100%" do
      lambda do
        value = 101 + @battery_tag
        Event.create_battery_entry(@user, value).should be_nil
      end.should_not change(Event, :count)
    end

    it "should update the user last battery value" do
      prng = Random.new(DateTime.now.second)
      battery_value = prng.rand(1..100)
      value = battery_value + @battery_tag
      event = Event.create_battery_entry(@user, value)
      @user.last_battery_value.should == event.value
    end
  end

  describe "create entry method" do
    it "should create a new entry" do
      lambda do
        tag = 0x01
        event = Event.create_entry(@user, tag)
        event.event_type.tag.should == tag
      end.should change(Event, :count).by(1)
    end

    it "should not create for an invalid tag" do
      lambda do
        unkwnown_tag = 0x3E
        event = Event.create_entry(@user, unkwnown_tag).should be_nil
      end.should_not change(Event, :count)
    end
  end

  describe "handle specific tags method" do
    before(:each) do
      @working_status_off = 0x02
      @working_status_on = 0x03
    end

    it "should handle a working status off message" do
        @user.online_status = true
        event = Event.create_entry(@user, @working_status_off)
        event.user.online_status.should be_false
    end

    it "should handle a working statun on message" do
        @user.online_status = false
        event = Event.create_entry(@user, @working_status_on)
        event.user.online_status.should be_true
    end
  end
end

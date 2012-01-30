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

class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :event_type

	validates :user_id,				:presence => true
	validates :event_type_id,	:presence => true
	validates :timestamp,  		:presence => true
	validates :handled,  			:inclusion => { :in =>  [true, false]}


	@battery_base_tag = 0x80

	def self.handle_event_entry(user, value)
		if (value > @battery_base_tag)
			create_battery_entry(user, value)
		else
			create_entry(user, value)
		end
	end

	def self.create_battery_entry(user, value)
		event_type = EventType.find_by_tag(@battery_base_tag)
		battery_level = value - @battery_base_tag

		return nil if battery_level > 100
		event = Event.create!(:event_type_id => event_type.id,
					  :user_id => user.id,
					  :timestamp => DateTime.now,
					  :value => battery_level,
					  :handled => false)

	  	user.update_attributes!(:last_battery_value => battery_level)
	  	return event
	end

	def self.create_entry(user, tag)
		event_type = EventType.find_by_tag(tag) 
		return nil if event_type.nil?

		event = Event.create!(:event_type_id => event_type.id,
					  :user_id => user.id,
					  :timestamp => DateTime.now,
					  :value => nil,
					  :handled => false)

	    event.handle_specific_tags
	end

	def handle_specific_tags
		specific_tags = {
			0x02 => :handle_working_status_off,
			0x03 => :handle_working_status_on
		}

		return self unless specific_tags.keys.include?(self.event_type.tag)
		
		send(specific_tags[event_type.tag])
		return self
	end

	def handle_working_status_off
		user.update_attributes!(:online_status => false)
	end

	def handle_working_status_on
		user.update_attributes!(:online_status => true)
	end
end

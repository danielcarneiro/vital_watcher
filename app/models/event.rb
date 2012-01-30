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

	battery_base_tag = 0x80

	def handle_event_entry(user, value)
		if (value > battery_base_tag) #battery tag
			create_battery_entry(user, value)
		else
			create_entry(user, value)
		end
	end

	def create_battery_entry(user, value)
		event_type = EventType.find_by_tag(battery_base_tag)
		battery_level = value - battery_base_tag
		Event.create!(:event_type_id => event_type.id,
					  :user_id => user.id,
					  :timestamp => DateTime.now,
					  :value => battery_value,
					  :handled => false)
	end

	def create_entry(user, tag)
		event_type = EventType.find_by_tag(tag) 
		Event.create!(:event_type_id => event_type.id,
					  :user_id => user.id,
					  :timestamp => DateTime.now,
					  :value => nil,
					  :handled => false)
	end
end

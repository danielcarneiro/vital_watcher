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
end

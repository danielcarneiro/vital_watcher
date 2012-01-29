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

class EventType < ActiveRecord::Base
	has_many :events, :dependent => :destroy
	
	validates	:name,	:presence => true
	validates	:mask,	:presence => true,
						:uniqueness => true

end

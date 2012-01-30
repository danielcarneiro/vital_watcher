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

class EventType < ActiveRecord::Base
	has_many :events, :dependent => :destroy
	
	validates	:name,	:presence => true,
						:uniqueness => true

	validates	:tag, 	:uniqueness => true,
						:numericality => {
							:only_integer => true,
							:less_than_or_equal_to => 0xFF
						}

end

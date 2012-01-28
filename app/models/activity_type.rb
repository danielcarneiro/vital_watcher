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

class ActivityType < ActiveRecord::Base

	validates	:name,	:presence => true
	validates	:tag, 	:uniqueness => true,
						:numericality => {
							:only_integer => true,
							:less_than_or_equal_to => 0xFF
						}

end

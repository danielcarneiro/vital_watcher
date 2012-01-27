# == Schema Information
#
# Table name: activities
#
#  id               :integer         not null, primary key
#  activity_type_id :integer
#  user_id          :integer
#  start_date       :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity_type

	validates :user_id,             :presence => true
  	validates :activity_type_id,  	:presence => true
  	validates :start_date,  		:presence => true

	default_scope :order => 'activities.start_date ASC'

	def self.handle_activity_entry(user, tag)
		at = ActivityType.find_by_tag(tag)
		return nil if at.nil?

		Activity.create!(:activity_type_id => at.id,
						 :user_id => user.id,
						 :start_date => DateTime.now)
	end
end

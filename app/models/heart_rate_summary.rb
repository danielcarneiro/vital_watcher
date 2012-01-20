# == Schema Information
#
# Table name: heart_rate_summaries
#
#  id                 :integer         not null, primary key
#  date               :date
#  occurrences        :integer
#  user_id            :integer
#  heart_rate_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class HeartRateSummary < ActiveRecord::Base
  belongs_to :user
  belongs_to :heart_rate_type

  def self.find_last_entry(user, heart_rate_type, date)
  	puts "user_id: #{user.id} heart_rate_type #{heart_rate_type.id}"
  	results = HeartRateSummary.where( :user_id => user.id, 
									:heart_rate_type_id => heart_rate_type.id, 
									:date => date)
	return results.first unless results.empty?
	return nil
  end

end

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

  validates :user_id,             :presence => true

  validates :heart_rate_type_id,  :presence => true

  validates :occurrences, :numericality => { :greater_than => 0 }

  def self.handle_heart_rate_entry(user, heart_rate_type, date, value)
    heart_rate_summary = HeartRateSummary.
      find_entry(user.id, hr_type.id, Date.today)
    
    if (heart_rate_summary == nil)
      create_new_heart_rate_summary_entry(user.id, hr_type.id)
    else
      add_heart_rate_entry(heart_rate_summary)
    end

    User.update(user.id, :last_heart_rate => value)
  end

  def self.find_entry(user_id, heart_rate_type_id, date)
  	results = HeartRateSummary.where( :user_id => user_id, 
									:heart_rate_type_id => heart_rate_type.id, 
									:date => date)
    return results.first unless results.empty?
    return nil
  end

  def create_new_heart_rate_summary_entry(user_id, heart_rate_type_id)
    HeartRateSummary.create!(:date => Date.today,
                  :occurrences => 1,
                  :user_id => user_id,
                  :heart_rate_type_id => heart_rate_type_id)
  end 

  def add_heart_rate_entry(heart_rate_summary)
    HeartRateSummary.update(heart_rate_summary.id,
                :occurrences => heart_rate_summary.occurrences + 1)
    
  end

  def self.find_user_heart_rates_by_date(user_id, date)
    results = HeartRateSummary.where( :user_id => user.id,
                                      :date => date )
  end

end

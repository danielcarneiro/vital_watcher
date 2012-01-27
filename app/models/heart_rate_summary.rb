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

  default_scope :order => 'heart_rate_summaries.heart_rate_type_id ASC'

  def self.handle_heart_rate_entry(user, heart_rate_type, value)
    puts "heart_rate_summary for #{user.id}, #{heart_rate_type.name}"

    begin
      heart_rate_summary = HeartRateSummary.
        find_entry(user.id, heart_rate_type.id, Date.today)
      
      puts "-> #{heart_rate_summary.class}"
      if (heart_rate_summary == nil)
        HeartRateSummary.create_new_entry(user.id, heart_rate_type.id)
      else
        heart_rate_summary.add_occurrence
      end

      User.update(user.id, :last_heart_rate => value)
    rescue Exception => exc
      puts "ERROR: #{exc.message}"
      puts exc.backtrace
    end
  end

  def self.find_entry(user_id, heart_rate_type_id, date)
  	results = HeartRateSummary.where( :user_id => user_id, 
									:heart_rate_type_id => heart_rate_type_id, 
									:date => date)
    return results.first unless results.empty?
    return nil
  end

  def self.find_user_heart_rates_by_date(user_id, date)
    results = HeartRateSummary.where( :user_id => user_id,
                                      :date => date )

    total = results.sum(:occurrences)
    results.each { |r| r.percent=(total) }
  end

  def percent=(results)
    p = occurrences * 100.0 / results
    @percent = "#{p.round(1)}%"
  end

  def percent
    @percent
  end

  def self.create_new_entry(user_id, heart_rate_type_id)
    HeartRateSummary.create!(:date => Date.today,
                  :occurrences => 1,
                  :user_id => user_id,
                  :heart_rate_type_id => heart_rate_type_id)
  end 

  def add_occurrence
    self.occurrences += 1
    self.save!
  end
end

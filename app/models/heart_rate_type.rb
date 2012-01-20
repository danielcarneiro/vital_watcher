# == Schema Information
#
# Table name: heart_rate_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  min_value  :integer
#  max_value  :integer
#  created_at :datetime
#  updated_at :datetime
#

class HeartRateType < ActiveRecord::Base
	has_many :heart_rate_summaries, :dependent => :destroy

  def self.find_by_value(value)
		HeartRateType.where(
			"(min_value <= :value or min_value is null) and (max_value > :value or max_value is null)", 
			{ :value => value }).first
  end
end

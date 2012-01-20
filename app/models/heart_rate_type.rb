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
end

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

require 'spec_helper'

describe HeartRateType do
  pending "add some examples to (or delete) #{__FILE__}"
end

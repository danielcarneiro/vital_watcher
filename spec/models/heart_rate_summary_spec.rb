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

require 'spec_helper'

describe HeartRateSummary do
  pending "add some examples to (or delete) #{__FILE__}"
end

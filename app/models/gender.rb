# == Schema Information
#
# Table name: genders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Gender < ActiveRecord::Base
	has_many :users

end

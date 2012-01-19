# == Schema Information
#
# Table name: devices
#
#  id          :integer         not null, primary key
#  mac_address :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Device < ActiveRecord::Base
	attr_accessible :mac_address

	belongs_to :user

	validates :mac_address, 	:presence 	=> true,
								:length		=> { :is => 17 },
								:uniqueness => { :case_sensitive => false }
end

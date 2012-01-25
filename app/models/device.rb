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

	mac_address_regex = /\A([0-9A-F]{2}(:|$)){6}\z/

	validates :mac_address, 	:presence 	=> true,
								:format 	=> { :with => mac_address_regex, 
												 :message => "should be uppercase and split by ':'"},
								:uniqueness => { :case_sensitive => false },
end

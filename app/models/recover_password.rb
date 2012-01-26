# == Schema Information
#
# Table name: recover_passwords
#
#  id         :integer         not null, primary key
#  token      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'base64'

class RecoverPassword < ActiveRecord::Base
	
	belongs_to :user

	attr_readonly :token

	attr_accessor :email, :password
	attr_accessible :email, :password

	validates	:user_id,	:presence => { :message => "with that email was not found" }

	validates	:password,	:presence	  => true,
							:confirmation => true,
	       					:length       => { :within => 6..40 },
	       					:on			  => :update

	before_validation :set_user
	before_create :generate_token

	def send_password_reset(url)
		Pony.mail(:to => self.email, 
					:subject => "Vital Watcher - Password Recovery",
					:body => url)
	end

	private
		def set_user
			self.user = User.find_by_email(email) if user.nil?
		end	
		
		def generate_token
			self.token = rand(36**8).to_s(36) if token.nil?
		end
end



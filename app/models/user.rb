# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  login              :string(255)
#  display_name       :string(255)
#  email              :string(255)
#  last_heart_rate    :integer
#  online_status      :boolean
#  last_battery_value :integer
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :login, :display_name, :email, :last_heart_rate,
					:online_status, :last_battery_value, 
					:password, :password_confirmation

	has_many :devices, :dependent => :destroy
	has_many :heart_rate_summaries, :dependent => :destroy
	has_many :recover_passwords, :dependent => :destroy

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		
	validates :login, 	:presence 	=> true,
						:length		=> { :maximum => 50 },
						:uniqueness => { :case_sensitive => false }

	validates :display_name,	:presence	=> true

	validates :email, 	:presence 	=> true,
						:format 	=> { :with => email_regex },
						:uniqueness => { :case_sensitive => false }

	validates :password,	:presence     => true,
	       					:length       => { :within => 6..40 },
	       					:on 		  => :create

	validates :password,	:confirmation => true

	validates :encrypted_password,	:presence     => true,
									:on => :update

	default_scope :order => 'users.display_name ASC'

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(login, submitted_password)
		user = find_by_login(login)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

  	def self.authenticate_with_salt(id, cookie_salt)
  		user = find_by_id(id)
  		(user && user.salt == cookie_salt) ? user : nil
  	end

  	def has_device?(mac_address)
  		devices.any? { |device| device.mac_address == mac_address }
  	end

	def self.find_by_device(mac_address)
		device = Device.find_by_mac_address(mac_address)
		return nil if device.nil?
		return device.user 
	end

	def update_password(password)
		self.password = password
		self.password_confirmation = password
		if self.valid?
			self.save!
			true
		else
			false
		end
	end

	private
		def encrypt_password
			self.salt = make_salt unless has_password?(password)
	 		self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

	 	def make_salt
	 		secure_hash("#{Time.now.utc}--#{password}")
	 	end

	 	def secure_hash(string)
	 		Digest::SHA2.hexdigest(string)
	 	end
end

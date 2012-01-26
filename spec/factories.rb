Factory.define :user do |user|
	user.sequence(:login)		{ |n| "login-#{n}" }
	user.display_name			"Daniel Carneiro"
	user.sequence(:email)		{ |n| "email-#{n}@vitalwatcher.com" }
	user.last_heart_rate		84
	user.online_status			true
	user.last_battery_value		47
	user.password				"foobar"
	user.password_confirmation	"foobar"
end

Factory.define :device do |device|
	device.mac_address "12:34:45:56:67:00"
	device.association :user
end

Factory.sequence :mac_address do |n|
	count = "%02x" % n
	"12:34:45:56:67:#{count}"
end

Factory.define :heart_rate_type do |heart_rate_type|
	heart_rate_type.name 		"110<130"
	heart_rate_type.min_value	110
	heart_rate_type.max_value	130
end

# FactoryGirl.define do
# 	factory :heart_rate_summary do
# 		date			Date.today
# 		occurrences		{ Factory.next(:occurrences) }
# 		user 			Factory(:user)
# 	end

# 	sequence(:occurrences) do |n|
# 		n
# 	end
# end

Factory.define :recover_password do |recover_password|
	recover_password.association	:user
	recover_password.email			"daniel.carneiro@biodevices.pt"
end
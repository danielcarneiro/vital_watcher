Factory.define :user do |user|
	user.login					"dcarneiro"
	user.display_name			"Daniel Carneiro"
	user.email					"daniel.carneiro@biodevices.pt"
	user.last_heart_rate		84
	user.online_status			true
	user.last_battery_value		47
	user.password				"foobar"
	user.password_confirmation	"foobar"
end

Factory.sequence :login do |n|
	"login-#{n}"
end

Factory.sequence :email do |n|
	"email-#{n}@vitalwatcher.com"
end

Factory.define :device do |device|
	device.mac_address "12:34:45:56:67:00"
	device.association :user
end

Factory.sequence :mac_address do |n|
	count = "%02x" % n
	"12:34:45:56:67:#{count}"
end

FactoryGirl.define do
	factory :heart_rate_type do
		name 	
		min_value
		max_value
	end

	sequence :name do |n|
		min_value = n * 20 + 40 unless n < 2
		max_value = n * 20 + 60 unless n > 3
		"#{min_value}<#{max_value}"
	end

	sequence :min_value do |n|
		n * 20 + 40 unless n < 2
	end

	sequence :max_value do |n|
		n * 20 + 60 unless n > 3
	end
end

Factory.define :recover_password do |recover_password|
	recover_password.association	:user
	recover_password.email			"daniel.carneiro@biodevices.pt"
end
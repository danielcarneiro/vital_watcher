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

Factory.define :device do |device|
	device.mac_address "12:34:45:56:67:00"
	device.association :user
end

Factory.sequence :mac_address do |n|
	count = "%02x" % n
	"12:34:45:56:67:#{count}"
end
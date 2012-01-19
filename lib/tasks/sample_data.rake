namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_devices
	end
end

def make_users
	User.create!(	:login => "dcarneiro",
									:display_name => "Daniel Carneiro", 
									:email => "daniel.carneiro@biodevices.pt",
									:last_heart_rate => 84,
									:online_status => true,
									:last_battery_value => 47,
									:password => "foobar",
									:password_confirmation => "foobar")
	prng = Random.new(1234)
	9.times do |n|
		display_name = Faker::Name.name
		login = (display_name[0] + display_name.split.last).downcase
		email = Faker::Internet.free_email
		password = "password"	
		User.create!(	:login => login,
									:display_name => display_name, 
									:email => email,
									:last_heart_rate => prng.rand(50..120),
									:online_status => [true, false].sample,
									:last_battery_value => prng.rand(10..100),
									:password => password,
									:password_confirmation => password)
	end
end

def make_devices
	prng = Random.new(12345)
	User.all(:limit => 3).each do |user|
		mac_address = ("%12x" % (prng.rand * 0xffffffffffff)).scan(/../).join(':').upcase
		user.devices.create!(:mac_address => mac_address)
	end
end
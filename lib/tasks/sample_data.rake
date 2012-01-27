namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_devices
		make_heart_rate_types
		make_activities_types
	end
end

def make_users
	admin = User.create!(	:login => "dcarneiro",
									:display_name => "Daniel Carneiro", 
									:email => "daniel.carneiro@biodevices.pt",
									:last_heart_rate => 84,
									:online_status => true,
									:last_battery_value => 47,
									:password => "foobar",
									:password_confirmation => "foobar")
	admin.toggle!(:admin)
	
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
	admin = User.find_by_admin(true)
	admin.devices.create!(:mac_address => "64:61:6E:69:65:6C")
	prng = Random.new(12345)
	mask = 0xffffffffffff
	User.all(:offset => 1, :limit => 3).each do |user|
		mac_address = ("%12x" % (prng.rand * mask)).scan(/../).join(':').upcase
		user.devices.create!(:mac_address => mac_address)
	end
end

def make_heart_rate_types
	HeartRateType.create!( :name => "<80",
							:max_value => 80 )
	HeartRateType.create!( :name => "80<100",
							:min_value => 80,
							:max_value => 100 )
	HeartRateType.create!( :name => "100<120",
							:min_value => 100,
							:max_value => 120 )
	HeartRateType.create!( :name => "<120",
							:min_value => 120 )
end

def make_activities_types
	ActivityType.create!( :name => "Stopped", :tag => 0 )
	ActivityType.create!( :name => "Moving", :tag => 1 )
	ActivityType.create!( :name => "Exercising", :tag => 2 )
	ActivityType.create!( :name => "Lying", :tag => 3 )
end
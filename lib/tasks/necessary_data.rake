namespace :db do
	desc "Fill database with the necessary data to run the app"
	task :setdata => :environment do
		Rake::Task['db:reset'].invoke
		make_admin
		make_device
		make_heart_rate_types
		make_activities_types
		make_events_types
	end
end

def make_admin
	admin = User.create!(	:login => "dcarneiro",
									:display_name => "Daniel Carneiro", 
									:email => "daniel.carneiro@biodevices.pt",
									:last_heart_rate => 84,
									:online_status => true,
									:last_battery_value => 47,
									:password => "foobar",
									:password_confirmation => "foobar")
	admin.toggle!(:admin)
end

def make_device
	admin = User.find_by_admin(true)
	admin.devices.create!(:mac_address => "64:61:6E:69:65:6C")
end

def make_heart_rate_types
	HeartRateType.create!( :name => "<80", :max_value => 80 )
	HeartRateType.create!( :name => "80<100", :min_value => 80,	:max_value => 100 )
	HeartRateType.create!( :name => "100<120", :min_value => 100, :max_value => 120 )
	HeartRateType.create!( :name => "<120",	:min_value => 120 )
end

def make_activities_types
	ActivityType.create!( :name => "Moving", :tag => 0x01 )
	ActivityType.create!( :name => "Exercising", :tag => 0x02 )
	ActivityType.create!( :name => "Lying", :tag => 0x03 )
	ActivityType.create!( :name => "Stopped", :tag => 0x04 )
end

def make_events_types
	EventType.create!( :name => "Panic Button", :tag => 0x01)
	EventType.create!( :name => "Working Status Off", :tag => 0x02)
	EventType.create!( :name => "Working Status On", :tag => 0x03)
	EventType.create!( :name => "Fall", :tag => 0x04)
	EventType.create!( :name => "Battery", :tag => 0x80)
end
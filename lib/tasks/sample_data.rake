namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:setdata'].invoke
		make_users
		make_devices
		make_heart_rate_summaries
		make_activities
		make_events
	end
end

def make_users
	prng = Random.new(DateTime.now.second)
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
	prng = Random.new(DateTime.now.second)
	mask = 0xffffffffffff
	User.all(:offset => 1, :limit => 3).each do |user|
		mac_address = ("%12x" % (prng.rand * mask)).scan(/../).join(':').upcase
		user.devices.create!(:mac_address => mac_address)
	end
end

def make_heart_rate_summaries
	prng = Random.new(DateTime.now.second)
	(1..5).each do |user_id|
		4.times do |n|
			HeartRateSummary.create!(:date => Date.today,
															 :occurrences => prng.rand(20..200),
															 :user_id => user_id,
															 :heart_rate_type_id => n + 1)
		end
	end
end

def make_activities
	prng = Random.new(DateTime.now.second)
	(1..5).each do |user_id|
		timestamp = DateTime.yesterday - 24.hours
		20.times do |n|
			Activity.create!(:activity_type_id => prng.rand(1..4),
											 :user_id => user_id,
											 :start_date => timestamp)

			timestamp = timestamp + prng.rand(10..60).minutes
		end
	end
end

def make_events
	prng = Random.new(DateTime.now.second)
	(1..5).each do |user_id|
		timestamp = DateTime.yesterday - 24.hours
		20.times do |n|
			event_type_id = prng.rand(1..5)
			event = Event.create!(:event_type_id => event_type_id,
							 :user_id => user_id,
							 :timestamp => timestamp,
							 :handled => false)

			event.update_attributes!(:value => prng.rand(10..100)) if event_type_id == 5

			timestamp = timestamp + prng.rand(10..60).minutes
		end
	end
end


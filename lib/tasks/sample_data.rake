namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:setdataup'].invoke
		make_users
		make_devices
		make_heart_rate_summaries
	end
end

def make_users
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
	mask = 0xffffffffffff
	User.all(:offset => 1, :limit => 3).each do |user|
		mac_address = ("%12x" % (prng.rand * mask)).scan(/../).join(':').upcase
		user.devices.create!(:mac_address => mac_address)
	end
end

def make_heart_rate_summaries
	prng = Random.new(1337)
	user_id = 1
	4.times do |n|
		HeartRateSummary.create!(:date => Date.today,
														 :occurrences => prng.rand(20..200),
														 :user_id => user_id,
														 :heart_rate_type_id => n + 1)
	end
end


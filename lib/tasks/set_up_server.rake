require 'socket'

namespace :server do
	desc "Start Vital Watcher TCP Server"
	task :start => :environment do
		@host = '0.0.0.0'
		port = ENV["PORT"] || 8443
		start_server(port)
	end
end

def start_server(port)
	puts "Trying to connect to #{@host}:#{port}"

	@server = TCPServer.new(@host, port)
	@logger = Logger.new('log/server/default.log', 'daily')

	@tags = {
	  0xFE => :handle_activities,
	  0xFF => :handle_events,
	}
	@tags.default = :handle_hr

	feedback("Server started on #{@host}:#{port}")
	connect
end

def connect
	handle_ctrl_c
	loop do
		Thread.start(@server.accept) do |tcpSocket|
			ip = connect_info(tcpSocket)
			begin
				receive_data(tcpSocket)
			rescue SystemCallError
				disconnect_info(ip)
				exit if @interrupted
			ensure
				s.close
			end 
		end
	end
end

def receive_data(tcpSocket)
	loop do
		recv = tcpSocket.recv(12).strip
		unless recv.blank? 
			handle_message recv
		end
	end
end

def connect_info(tcpSocket)
	port, ip = Socket.unpack_sockaddr_in(tcpSocket.getpeername)
	feedback "connection open with #{ip}"
	ip
end

def disconnect_info(ip)
	feedback "connection closed with #{ip}"
end

def handle_ctrl_c
	#handle Ctrl+C
	Kernel.trap('INT') do
	  @interrupted = true
	  disconnect
	  exit
	end
end

def disconnect
	@server.close
	feedback("server closed")
end

def feedback(message)
	message = message.strip
	@logger.info(message)
	puts message
end

def handle_message(message)
	byte_array = convert_to_byte_array(message)
	log_received_message byte_array

	if (byte_array.length < 7)
		feedback "short message: #{array}"
		return nil
	end

	address = get_mac_address(byte_array.first(6))
	user = User.find_by_device(address)
	if (user == nil)
		feedback "unknown user for mac_address: #{address}"
		return
	end
	parse_user_message(user, byte_array[6..byte_array.length])
end

def convert_to_byte_array(message)
	array = Array.new
	message.each_byte { |b| array << b }
	array
end

def log_received_message(array)
	feedback_message = ""
	array.each { |char| feedback_message << "%02x" % char}
	feedback "recv> #{feedback_message}"
end

def get_mac_address(array)
	parsed_string = ""
	array.each { |char| parsed_string << "%02x"% char}
	parsed_string.scan(/../).join(':').upcase
end

def parse_user_message(user, array)
	value = array.length == 1 ? array[0] : array[1]
	send(@tags[array.first], user, value)
end

def handle_hr(user, value)
	feedback "handle_hr: #{user.display_name}, #{value}"
	hr_type = HeartRateType.find_by_value(value)
	HeartRateSummary.handle_heart_rate_entry(user, hr_type, value)
end

def handle_activities(user, value)
	feedback "handle_activities #{value}"
end

def handle_events(user, value)
	feedback "handle_events #{value}"
end

class Marshalling
	include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :user_id, :timestamp, :user, 
                :request, :response

  validates	:user_id, :presence	=> true
  validates	:user, :presence	=> true
  validates	:timestamp, :presence => true
  validates :request, :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end

    @messages = {
      "user_data" => :parse_user_data,
      "battery" => :parse_battery,
      "heart_rate_today" => :parse_heart_rate_today,
      "heart_rate_week" => :parse_heart_rate_week,
      "heart_rate_month" => :parse_heart_rate_month,
      "heart_rate" => :parse_heart_rate,
      "heart_rate_history" => :parse_heart_rate_history,
    }

    @response = { "timestamp" => DateTime.now.to_i }
  end

  def persisted?
    false
  end

  def user_id=(value)
  	@user_id = value
  	@user = User.find_by_id(user_id)
  end

  def user=(value)
  	@user = value
  	@user_id = value.id
  end

  def self.parse_message(message)
    marshall = Marshalling.new(message)
    marshall.parse_request
    marshall
  end

  def parse_request
    request.each do |token|
      send(@messages[token]) if @messages.has_key?(token)
    end
  end

  def parse_user_data
    return nil if self.response.has_key?("user_data")
    response["user_data"] = user
  end

  def parse_battery
    return nil if self.response.has_key?("battery")
    response["battery"] = user.last_battery_value
  end

  def parse_heart_rate_today
  	
  end

  def parse_heart_rate_week
  	
  end

  def parse_heart_rate_month
  	
  end

	def parse_heart_rate
		
	end

  def parse_heart_rate_history
  	
  end
end

# json = JSONBuilder::Compiler.generate do
#   		timestamp DateTime.now.to_i
# 			if 
# 				user
# 			then
# 				id user.id
# 				display_name user.display_name
# 				login user.login
# 				email user.email
# 				birth_date user.birth_date.nil? ? nil :  user.birth_date.to_i
# 				gender user.gender.nil? ? nil : user.gender.name
# 				online_status user.online_status
# 				battery user.last_battery_value
# 			else
# 				id -1
# 				error "unknown user"
# 			end
#   	end
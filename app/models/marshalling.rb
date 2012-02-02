class Marshalling
	include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  require 'json_builder'

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

  @messages = {
  	"user_data" => :parse_user_data,
  	"battery" => :parse_battery,
  	"heart_rate_today" => :parse_heart_rate_today,
  	"heart_rate_week" => :parse_heart_rate_week,
  	"heart_rate_month" => :parse_heart_rate_month,
  	"heart_rate" => :parse_heart_rate,
  	"heart_rate_history" => :parse_heart_rate_history,
  }

  def self.parse_request(request)
    marshall = Marshalling.new(request)
    marshall.response = {
      "timestamp" => DateTime.now.to_i
    }

    marshall
  end

  def parse_user_data
    response << { "user_data" => user }
  end

  def parse_battery

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
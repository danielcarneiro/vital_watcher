class MarshallingController < ApplicationController

	respond_to :json

  def index
  	message = Hash.new
  	message["user_id"] = params[:user_id]
  	message["timestamp"] = params[:timestamp]
  	message["request"] = params[:request]

  	marshall = Marshalling.parse_message(message)
  	@response = marshall.response

  	ap 'response'
  	ap @response.class
  	ap @response
  	respond_with @response
  end

end

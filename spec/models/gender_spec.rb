# == Schema Information
#
# Table name: genders
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Gender do
	it "should have a user attribute" do
      Gender.new.should respond_to(:users)
    end
end

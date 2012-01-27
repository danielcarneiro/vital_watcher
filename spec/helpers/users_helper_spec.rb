require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do

	before(:each) do
    @user = Factory.build(:user)
  end

	describe "status for" do
		describe "online user" do
			it "should include online"	do
				helper.status_for(@user).should include "online"
			end

			it "should include battery"	do
				helper.status_for(@user).should include "battery"
			end
		end

		describe "offline user" do
			before(:each) do
				@offline_user = Factory.build(:user, :online_status => false)
			end
			
			it "should return offline" do
				helper.status_for(@offline_user).should == "offline"
			end
		end
	end

end

# == Schema Information
#
# Table name: recover_passwords
#
#  id         :integer         not null, primary key
#  token      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe RecoverPassword do
  before(:each) do
  	@user = Factory(:user)
    @attr = { 
      :email => @user.email
    }
  end

  describe "validations" do
    before(:each) do
      
    end

    it "should fail for a nil user" do
      recover_password = RecoverPassword.new(:user => nil)
      recover_password.should_not be_valid
    end
  end

  it "should not be able to change the token" do
  	recover_password = RecoverPassword.create(@attr, :user => @user)
    token = recover_password.token
  	recover_password.update_attributes :token => 'bar'
  	recover_password.reload.token.should eql token 
  end

  it "should generate a random 8char token while saving" do
  	lambda do
  		recover_password = RecoverPassword.new(:user => @user)
  		recover_password.save
  		recover_password.token.length.should == 8
	end 
  end
end



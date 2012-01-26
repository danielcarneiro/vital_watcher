# == Schema Information
#
# Table name: heart_rate_summaries
#
#  id                 :integer         not null, primary key
#  date               :date
#  occurrences        :integer
#  user_id            :integer
#  heart_rate_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe HeartRateSummary do

  before(:each) do
  	@user = Factory(:user)
    @attr = { 
      :date => Date.today,
      :occurrences => 5, 
      :heart_rate_type_id => 1
    }
  end
  
  it "should create a new instance given valid attributes" do
  	@user.heart_rate_summaries.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @heart_rate_summary = @user.heart_rate_summaries.create(@attr)
    end

    it "should have a user attribute" do
      @heart_rate_summary.should respond_to(:user)
    end

    it "should have the right associated user" do
      @heart_rate_summary.user_id.should == @user.id
      @heart_rate_summary.user.should == @user
    end
  end

  describe "heart rate type associations" do
    lambda do
      before(:each) do
        @heart_rate_type = Factory.create(:heart_rate_type)
        @heart_rate_summary = @heart_rate_type.heart_rate_summaries.create(@attr)
      end

      it "should have a heart rate type attribute" do
        @heart_rate_summary.should respond_to(:heart_rate_type)
      end

      it "should have the right associated heart rate type" do
        @heart_rate_summary.heart_rate_type_id.should == @heart_rate_type.id
        @heart_rate_summary.heart_rate_type.should == @heart_rate_type
      end
    end
  end

  describe "validations" do
    it "should require a user id" do
      HeartRateSummary.new(@attr).should_not be_valid
    end

    it "should require a heart_rate_type id" do
      HeartRateSummary.new(@attr.merge(:user_id => 1, 
                                      :heart_rate_type_id => nil))
        .should_not be_valid
    end

    it "should have more that 0 occurrences" do
      HeartRateSummary.new(@attr.merge(:occurrences => 0)).should_not be_valid
    end
  end

  describe "should create a new entry" do
    lambda do
      count = HeartRateSummary.count
      HeartRateSummary.create_new_entry(@user, @heart_rate_type)
      HeartRateSummary.count.should eql count + 1
    end
  end

  describe "should increase the occurrences of the heart rate summary entry by 1" do
    lambda do
      heart_rate_summary = HeartRateSummary.create!(@attr)
      heart_rate_summary.add_occurrence
      heart_rate_summary.occurrences.should eql @attr[:occurrences] + 1
    end
  end
end

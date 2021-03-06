# == Schema Information
#
# Table name: heart_rate_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  min_value  :integer
#  max_value  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe HeartRateType do
  before(:each) do
    @attr = { 
      :name => "140<160",
      :min_value => 140, 
      :max_value => 160,
    }
  end

  it "should create a new instance given valid attributes" do
    HeartRateType.create!(@attr)
  end

  it "should not create when name is nil or empty" do
    HeartRateType.new(@attr.merge(:name => "")).should_not be_valid
  end

  it "should create when min value is nil" do
    HeartRateType.new(@attr.merge(:min_value => nil)).should be_valid
  end

	it "should create when max value is nil" do
    HeartRateType.new(@attr.merge(:max_value => nil)).should be_valid
  end

  it "should not create when both min value and max value are nil" do
    HeartRateType.new(@attr.merge(:min_value => nil, :max_value => nil)).
    	should_not be_valid
  end

  it "should fail to create when min_value > max_value" do
    invalid_heart_rate_type = HeartRateType.new(@attr.merge(:min_value => 100, :max_value => 80))
    invalid_heart_rate_type.should_not be_valid
  end

  describe "should find by value" do

    it "for lower values" do
      value = 1
      heart_rate_type = HeartRateType.find_by_value(value)
      heart_rate_type.min_value.should be_nil
      heart_rate_type.max_value.should be > value
    end

    it "for intermediate values" do
      value = 90
      heart_rate_type = HeartRateType.find_by_value(value)
      heart_rate_type.min_value.should be <= value
      heart_rate_type.max_value.should be > value
    end

    it "for upper values" do
      value = 9000
      heart_rate_type = HeartRateType.find_by_value(value)
      heart_rate_type.min_value.should be <= value
      heart_rate_type.max_value.should be_nil
    end
  end
end

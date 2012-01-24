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
      :name => "80<100",
      :min_value => 80, 
      :max_value => 100,
    }
  end

  it "should create a new instance given valid attributes" do
    HeartRateType.create!(@attr)
  end

  it "should not create when name is nil or empty" do
    HeartRateType.create!(@attr.merge(:name => "")).should_not be_valid
  end

  it "should create when min value is nil" do
    HeartRateType.create!(@attr.merge(:min_value => nil)).should be_valid
  end

	it "should create when max value is nil" do
    HeartRateType.create!(@attr.merge(:max_value => nil)).should be_valid
  end

  it "should not create when both min value and max value are nil" do
    HeartRateType.create(@attr.merge(:min_value => nil, :max_value => nil)).
    	should_not be_valid
  end

  it "should fail to create when min_value > max_value" do
    invalid_heart_rate_type = HeartRateType.create(@attr.merge(:min_value => 100, :max_value => 80))
    invalid_heart_rate_type.should_not be_valid
  end
end

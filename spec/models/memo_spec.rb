require 'spec_helper'

describe Memo do
  before(:each) do
    @valid_attributes = {
      :text => 'something i want to remember'
    }
  end

  it "should create a new instance given valid attributes" do
    Memo.create!(@valid_attributes)
  end
end

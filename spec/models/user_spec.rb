require 'spec_helper'

describe User, '#absorb' do
  it "should claim the other user's memos" do
    absorber = User.create!
    absorbee = User.create!
    (1+rand(4)).times do |i|
      absorbee.memos.create! :text => "memo #{i}"
    end
    memos = absorbee.memos
    absorber.absorb absorbee
    absorber.memos.should == memos
  end

  it 'should destroy the other user' do
    absorber = User.create!
    absorbee = User.create!
    absorber.absorb absorbee
    absorbee.should be_destroyed
  end
end

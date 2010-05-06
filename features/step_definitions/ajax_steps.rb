Given /^my memos "([^\"]*)" and "([^\"]*)"$/ do |text1, text2|
  Given 'I found my user account'
  @user.memos.create :text => text1
  @user.memos.create :text => text2
end

Given 'I have three old memos' do
  Given 'I found my user account'
  3.times do |i|
    m = @user.memos.create! :text => "old memo #{i}"
    m.update_attribute :repeat_at, Time.now - 1.week.to_i * rand
  end
end

Then 'the page should not change again' do
  evaluate_script('window.onunload = window.stop')
end

Then 'there should be one memo left to view' do
  locate('#to_go .count').text.to_i.should == 1
end

Then 'there should be one more memo left to view' do
  locate('#to_go .count').text.should == (@before_count + 1).to_s
end

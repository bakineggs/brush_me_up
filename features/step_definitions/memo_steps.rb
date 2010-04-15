Given /^the memo "([^\"]*)"$/ do |text|
  Memo.create! :text => text
end

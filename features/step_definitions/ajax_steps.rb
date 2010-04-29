Then 'the page should not change again' do
  evaluate_script('window.onunload = function() { window.stop(); }')
end

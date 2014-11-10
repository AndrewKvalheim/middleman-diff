When(/^it should fail with "(.*?)"$/) do |output|
  step 'it should fail with:', output
end

When(/^it should pass with "(.*?)"$/) do |output|
  step 'it should pass with:', output
end

When(/^I attempt to diff$/) do
  step 'I run `middleman diff`'
end

When(/^I diff noninteractively$/) do
  step 'I attempt to diff'
  step 'the exit status should be 0'
end

When(/^I diff$/) do
  step 'I diff and type ""'
end

When(/^I diff and type "(.*?)"$/) do |text|
  step 'I run `middleman diff` interactively'
  step "I type \"#{ text }\""
  step 'the exit status should be 0'
end

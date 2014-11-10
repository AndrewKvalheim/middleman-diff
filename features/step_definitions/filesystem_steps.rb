require 'fileutils'
require 'pathname'

Then(/^a directory named "(.*?)" should be empty$/) do |path|
  in_current_dir do
    Pathname.new(path).children.empty?
  end
end

Given(/^a fixture app "(.*?)" without "(.*?)"$/) do |name, path|
  step "a fixture app \"#{ name }\""
  in_current_dir do
    FileUtils.rmtree path
  end
end

Given(/^the text "(.*?)" in the file "(.*?)" is replaced with:$/) do |text, path, replacement|
  in_current_dir do
    content = open(path) { |file| file.read }

    open(path, 'w') do |file|
      file.write content.gsub(text, replacement)
    end
  end
end

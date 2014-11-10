activate :diff

before_build do
  puts 'The before_build hook has been run.'
end

after_build do
  puts 'The after_build hook has been run.'
end

# Workaround for middleman/middleman#706
configure :build do
  compass_config do |config|
    config.sass_options = { line_comments: false }
  end
end

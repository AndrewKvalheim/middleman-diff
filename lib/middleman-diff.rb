require 'middleman-core'

# Extension namespace
class MyExtension < ::Middleman::Extension
  option :my_option, 'default', 'An example option'

  def initialize(app, **options_hash, &block)
    # Build options from options_hash
    super
  end
end

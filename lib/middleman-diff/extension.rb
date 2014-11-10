require 'middleman-core'

module Middleman
  module Diff
    # Middleman extension
    class Extension < ::Middleman::Extension
      option :build_hooks, true,
             'Whether to run build hooks when previewing the build'
      option :keep, :prompt,
             'Whether to :always, :never, or :prompt to keep the preview'
      option :temp_dir, 'tmp',
             'Path in which to build when previewing'

      # Runs when the extension is activated
      #
      # @param app [Middleman::Application] Middleman application instance
      # @param options_hash [Hash] options
      # @param block [Block] configuration block
      # @return [void]
      def initialize(app, **options_hash, &block)
        # Build options from options_hash
        super

        require 'middleman-diff/preview'
        require 'pathname'
      end

      # Yield a preview of the build.
      #
      # @yield [Middleman::Diff::Preview]
      # @yieldreturn [void]
      # @return [void]
      def with_preview
        preview = Preview.new(app, build_hooks: options.build_hooks,
                                   temp_dir: options.temp_dir)

        yield preview

        preview.dispose
      end
    end
  end
end

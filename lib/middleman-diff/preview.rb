require 'fileutils'
require 'pathname'
require 'rack/test' # Required by Middleman::Cli::Build
require 'tmpdir'

module Middleman
  module Diff
    # Preview of the build
    class Preview
      # Generate a preview of the build.
      #
      # @param app [Middleman::Appliation] Middleman application instance
      # @param build_hooks [Boolean]
      # @param temp_dir [String] path to temporary directory
      # @return [void]
      def initialize(app, build_hooks: true, temp_dir: 'tmp')
        @app = app
        @build_hooks = build_hooks
        @temp_dir = Pathname.new(temp_dir)

        build_preview
      end

      # Clean up any temporary files from the preview.
      #
      # @return [void]
      def dispose
        preview_dir.rmtree if preview_dir.exist?
      end

      # Replace the existing build with the preview.
      #
      # @return [void]
      def replace_build
        build_dir.rmtree
        FileUtils.move preview_dir, build_dir
      end

      # Output a diff of the existing build and preview.
      #
      # @return [void]
      def show_diff
        prefix = %w(git diff --no-index --patch-with-stat --)
        system(*(prefix + [build_dir.to_s, preview_dir.to_s]))
      end

      private

      # Instance of the CLI used for building
      #
      # @return [thor_with_preview_dir]
      def build_cli
        @_build_cli ||= build_cli_with_preview_dir.new
      end

      # A modified Middleman::Cli::Build that builds to the preview directory
      #
      # @return [Class]
      def build_cli_with_preview_dir
        current_preview_dir = preview_dir

        Class.new(::Middleman::Cli::Build).tap do |klass|
          klass.define_singleton_method(:shared_instance) do
            @_shared_instance ||= ::Middleman::Application.server.inst do
              set :build_dir, current_preview_dir
              config[:environment] = :build
            end
          end
        end
      end

      # Build into the preview directory.
      #
      # @return [void]
      def build_preview
        trigger_build_hook :before_build
        build_cli.action Middleman::Cli::BuildAction.new(build_cli, {})
        trigger_build_hook :after_build
      end

      # Directory of the existing build
      #
      # @return [Pathname]
      def build_dir
        @_build_dir ||= begin
          dir = Pathname.new(@app.build_dir)

          unless dir.exist?
            fail Thor::Error, "There's no existing build to compare against."
          end

          dir
        end
      end

      # Directory in which to build the preview
      #
      # @return [Pathname]
      def preview_dir
        @_preview_dir ||= begin
          Pathname.new(Dir.mktmpdir('preview_', @temp_dir.tap(&:mkpath)))
        end
      end

      # Run a build hook.
      #
      # @param name [Symbol]
      # @return [void]
      def trigger_build_hook(name)
        return unless @build_hooks

        build_cli.class.shared_instance.run_hook name, build_cli
      end
    end
  end
end

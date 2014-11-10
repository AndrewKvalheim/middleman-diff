require 'middleman-core/cli'

module Middleman
  module Cli
    # Extension to the Middleman CLI
    class Diff < Thor
      include Thor::Actions

      namespace :diff

      # Whether to exit with status 1 when a failure happens
      #
      # @return [Boolean]
      def self.exit_on_failure?
        true
      end

      # Interactively diff a preview with the build, optionally replacing the
      # existing build with it.
      #
      # @return [void]
      desc 'diff', "Preview what's changed in the build."
      def diff
        extension.with_preview do |preview|
          preview.show_diff

          if keep?
            preview.replace_build
            say 'Build has been updated.'
          else
            say 'Preview has been discarded.'
          end
        end
      end

      private

      # Middleman application instance
      #
      # @return [Middleman::Application]
      def app
        @_app ||= ::Middleman::Application.server.inst
      end

      # Activated extension instance
      #
      # @return [Middleman::Extensions::Diff]
      def extension
        @_extension ||= begin
          extension = app.extensions.find { |e| e.first == :diff }.try(:last)

          fail Thor::Error, 'You must activate this extension.' unless extension

          extension
        end
      end

      # Whether to replace the existing build with the preview
      #
      # @return [Boolean]
      def keep?
        case extension.options.keep
        when :always then true
        when :never then false
        when :prompt
          yes?('Would you like to apply these changes to the build? [y/N]')
        end
      end
    end
  end
end

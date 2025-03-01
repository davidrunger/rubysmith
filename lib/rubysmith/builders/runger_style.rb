# frozen_string_literal: true

require 'refinements/structs'

module Rubysmith
  module Builders
    # Builds project skeleton with RungerStyle style support.
    class RungerStyle
      using Refinements::Structs

      def self.call(...) = new(...).call

      def initialize(configuration, builder: Builder)
        @configuration = configuration
        @builder = builder
      end

      def call
        return configuration unless configuration.build_runger_style

        builder.call(configuration.merge(template_path: '%project_name%/bin/rubocop.erb')).
          render.
          permit(0o755)

        builder.call(configuration.merge(template_path: '%project_name%/.rubocop.yml.erb')).render
        configuration
      end

      private

      attr_reader :configuration, :builder
    end
  end
end

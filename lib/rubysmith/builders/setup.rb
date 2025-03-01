# frozen_string_literal: true

require 'refinements/structs'

module Rubysmith
  module Builders
    # Builds project skeleton setup script.
    class Setup
      using Refinements::Structs

      def self.call(...) = new(...).call

      def initialize(configuration, builder: Builder)
        @configuration = configuration
        @builder = builder
      end

      def call
        return configuration unless configuration.build_setup

        builder.call(configuration.merge(template_path: '%project_name%/bin/setup.erb')).
          render.
          permit(0o755)

        configuration
      end

      private

      attr_reader :configuration, :builder
    end
  end
end

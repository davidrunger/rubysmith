# frozen_string_literal: true

require 'refinements/structs'

module Rubysmith
  module Builders
    module RSpec
      # Builds RSpec `.rspec` file for project skeleton.
      class Dotrspec
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize(configuration, builder: Builder)
          @configuration = configuration
          @builder = builder
        end

        def call
          return configuration unless configuration.build_rspec

          builder.call(configuration.merge(template_path: '%project_name%/.rspec.erb')).
            render.
            replace("\n\n\n", "\n\n")

          configuration
        end

        private

        attr_reader :configuration, :builder
      end
    end
  end
end

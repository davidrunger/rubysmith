# frozen_string_literal: true

require "refinements/structs"

module Rubysmith
  module Builders
    # Builds project skeleton GitHub templates.
    class GitHub
      using Refinements::Structs

      def self.call(...) = new(...).call

      def initialize configuration, builder: Builder
        @configuration = configuration
        @builder = builder
      end

      def call
        return configuration unless configuration.build_git_hub

        builder.call(with_issue_template).render
        builder.call(with_pull_request_template).render
        configuration
      end

      private

      attr_reader :configuration, :builder

      def with_issue_template
        configuration.merge template_path: "%project_name%/.github/ISSUE_TEMPLATE.md.erb"
      end

      def with_pull_request_template
        configuration.merge template_path: "%project_name%/.github/PULL_REQUEST_TEMPLATE.md.erb"
      end
    end
  end
end

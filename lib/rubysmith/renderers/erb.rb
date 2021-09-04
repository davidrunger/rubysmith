# frozen_string_literal: true

require "erb"

module Rubysmith
  module Renderers
    # Renders ERB templates as fully functional files.
    class ERB
      def initialize configuration,
                     scope: Renderers::Namespace.new(configuration.project_class),
                     client: ::ERB
        @configuration = configuration
        @scope = scope
        @client = client
      end

      def call(content) = client.new(content, trim_mode: "<>", eoutvar: "@buffer").result(binding)

      private

      attr_accessor :buffer
      attr_reader :configuration, :scope, :client

      def namespace = self.buffer = block_given? ? scope.call(yield) : buffer + scope.call
    end
  end
end

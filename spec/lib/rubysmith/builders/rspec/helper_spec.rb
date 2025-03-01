# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rubysmith::Builders::RSpec::Helper do
  using Refinements::Structs

  subject(:builder) { described_class.new(test_configuration) }

  include_context 'with application dependencies'

  let(:spec_helper_path) { temp_dir.join('test/spec/spec_helper.rb') }

  it_behaves_like 'a builder'

  describe '#call' do
    before { builder.call }

    context 'when enabled with no options' do
      let(:test_configuration) { configuration.minimize.merge(build_rspec: true) }

      let :proof do
        <<~BODY
          require "bundler/setup"
          Bundler.require :tools

          require "test"

          Dir[File.join(__dir__, "support", "shared_contexts", "**/*.rb")].sort.each { |path| require path }

          RSpec.configure do |config|
            config.color = true
            config.disable_monkey_patching!
            config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
            config.filter_run_when_matching :focus
            config.formatter = ENV.fetch("CI", false) == "true" ? :progress : :documentation
            config.order = :random
            config.shared_context_metadata_behavior = :apply_to_host_groups
            config.warnings = true

            config.expect_with :rspec do |expectations|
              expectations.syntax = :expect
              expectations.include_chain_clauses_in_custom_matcher_descriptions = true
            end

            config.mock_with :rspec do |mocks|
              mocks.verify_doubled_constant_names = true
              mocks.verify_partial_doubles = true
            end
          end
        BODY
      end

      it 'builds spec helper' do
        expect(spec_helper_path.read).to eq(proof)
      end
    end

    context 'when enabled with dashed project name' do
      let :test_configuration do
        configuration.minimize.merge(project_name: 'demo-test', build_rspec: true)
      end

      let :proof do
        <<~BODY
          require "bundler/setup"
          Bundler.require :tools

          require "demo/test"

          Dir[File.join(__dir__, "support", "shared_contexts", "**/*.rb")].sort.each { |path| require path }

          RSpec.configure do |config|
            config.color = true
            config.disable_monkey_patching!
            config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
            config.filter_run_when_matching :focus
            config.formatter = ENV.fetch("CI", false) == "true" ? :progress : :documentation
            config.order = :random
            config.shared_context_metadata_behavior = :apply_to_host_groups
            config.warnings = true

            config.expect_with :rspec do |expectations|
              expectations.syntax = :expect
              expectations.include_chain_clauses_in_custom_matcher_descriptions = true
            end

            config.mock_with :rspec do |mocks|
              mocks.verify_doubled_constant_names = true
              mocks.verify_partial_doubles = true
            end
          end
        BODY
      end

      it 'builds spec helper' do
        expect(temp_dir.join('demo-test/spec/spec_helper.rb').read).to eq(proof)
      end
    end

    context 'when enabled with Refinements only' do
      let :test_configuration do
        configuration.minimize.merge(build_rspec: true, build_refinements: true)
      end

      let :proof do
        <<~BODY
          require "bundler/setup"
          Bundler.require :tools

          require "test"
          require "refinements"

          using Refinements::Pathnames

          Pathname.require_tree __dir__, "support/shared_contexts/**/*.rb"

          RSpec.configure do |config|
            config.color = true
            config.disable_monkey_patching!
            config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
            config.filter_run_when_matching :focus
            config.formatter = ENV.fetch("CI", false) == "true" ? :progress : :documentation
            config.order = :random
            config.shared_context_metadata_behavior = :apply_to_host_groups
            config.warnings = true

            config.expect_with :rspec do |expectations|
              expectations.syntax = :expect
              expectations.include_chain_clauses_in_custom_matcher_descriptions = true
            end

            config.mock_with :rspec do |mocks|
              mocks.verify_doubled_constant_names = true
              mocks.verify_partial_doubles = true
            end
          end
        BODY
      end

      it 'builds spec helper' do
        expect(spec_helper_path.read).to eq(proof)
      end
    end

    context 'when enabled with SimpleCov only' do
      let :test_configuration do
        configuration.minimize.merge(build_rspec: true, build_simple_cov: true)
      end

      let :proof do
        <<~BODY
          require "bundler/setup"
          Bundler.require :tools

          require "simplecov"

          unless ENV["NO_COVERAGE"]
            SimpleCov.start do
              enable_coverage :branch
              add_filter %r(^/spec/)
              minimum_coverage_by_file line: 95, branch: 95
            end
          end

          require "test"

          Dir[File.join(__dir__, "support", "shared_contexts", "**/*.rb")].sort.each { |path| require path }

          RSpec.configure do |config|
            config.color = true
            config.disable_monkey_patching!
            config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
            config.filter_run_when_matching :focus
            config.formatter = ENV.fetch("CI", false) == "true" ? :progress : :documentation
            config.order = :random
            config.shared_context_metadata_behavior = :apply_to_host_groups
            config.warnings = true

            config.expect_with :rspec do |expectations|
              expectations.syntax = :expect
              expectations.include_chain_clauses_in_custom_matcher_descriptions = true
            end

            config.mock_with :rspec do |mocks|
              mocks.verify_doubled_constant_names = true
              mocks.verify_partial_doubles = true
            end
          end
        BODY
      end

      it 'builds spec helper' do
        expect(spec_helper_path.read).to eq(proof)
      end
    end

    context 'when enabled with all options' do
      let(:test_configuration) { configuration.maximize }

      let :proof do
        <<~BODY
          require "bundler/setup"
          Bundler.require :tools

          require "simplecov"

          unless ENV["NO_COVERAGE"]
            SimpleCov.start do
              enable_coverage :branch
              add_filter %r(^/spec/)
              minimum_coverage_by_file line: 95, branch: 95
            end
          end

          require "test"
          require "refinements"

          using Refinements::Pathnames

          Pathname.require_tree __dir__, "support/shared_contexts/**/*.rb"

          RSpec.configure do |config|
            config.color = true
            config.disable_monkey_patching!
            config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
            config.filter_run_when_matching :focus
            config.formatter = ENV.fetch("CI", false) == "true" ? :progress : :documentation
            config.order = :random
            config.shared_context_metadata_behavior = :apply_to_host_groups
            config.warnings = true

            config.expect_with :rspec do |expectations|
              expectations.syntax = :expect
              expectations.include_chain_clauses_in_custom_matcher_descriptions = true
            end

            config.mock_with :rspec do |mocks|
              mocks.verify_doubled_constant_names = true
              mocks.verify_partial_doubles = true
            end
          end
        BODY
      end

      it 'builds spec helper' do
        expect(spec_helper_path.read).to eq(proof)
      end
    end

    context 'when disabled' do
      let(:test_configuration) { configuration.minimize }

      it "doesn't build spec helper" do
        expect(spec_helper_path.exist?).to be(false)
      end
    end
  end
end

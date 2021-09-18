# frozen_string_literal: true

require "dry/container/stub"

RSpec.shared_context "with application container" do
  using Refinements::Structs

  include_context "with temporary directory"

  let(:application_container) { Rubysmith::Container }

  let :application_configuration do
    Rubysmith::CLI::Configuration::Loader.with_defaults.call.merge(**minimum_configuration.to_h)
  end

  let :minimum_configuration do
    Rubysmith::CLI::Configuration::Content[
      author_email: "jill@example.com",
      author_name: "Jill Smith",
      author_url: "https://www.jillsmith.com",
      builders_pragmater_comments: ["# frozen_string_literal: true"],
      builders_pragmater_includes: ["**/*.rb"],
      git_hub_user: "hubber",
      now: Time.local(2020, 1, 1, 0, 0, 0),
      project_name: "test",
      target_root: temp_dir,
      template_root: Bundler.root.join("lib/rubysmith/templates")
    ]
  end

  let(:kernel) { class_spy Kernel }

  before do
    application_container.enable_stubs!
    application_container.stub :configuration, application_configuration
    application_container.stub :kernel, kernel
  end

  after do
    application_container.unstub :configuration
    application_container.unstub :kernel
  end
end

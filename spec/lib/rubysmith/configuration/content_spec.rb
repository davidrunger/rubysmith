# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rubysmith::Configuration::Content do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:content) { described_class[project_name: 'test'] }

  let(:template_root) { Bundler.root.join('lib', 'rubysmith', 'templates') }
  let(:target_root) { Bundler.root }

  describe '#initialize' do
    let :proof do
      {
        action_build: nil,
        action_config: nil,
        action_edit: nil,
        action_help: nil,
        action_install: nil,
        action_publish: nil,
        action_version: nil,
        action_view: nil,
        author_email: nil,
        author_family_name: nil,
        author_given_name: nil,
        author_url: nil,
        build_amazing_print: nil,
        build_bundler_leak: nil,
        build_circle_ci: nil,
        build_citation: nil,
        build_cli: nil,
        build_community: nil,
        build_conduct: nil,
        build_console: nil,
        build_contributions: nil,
        build_debug: nil,
        build_funding: nil,
        build_git: nil,
        build_git_hub: nil,
        build_git_lint: nil,
        build_guard: nil,
        build_license: nil,
        build_maximum: nil,
        build_minimum: nil,
        build_rake: nil,
        build_readme: nil,
        build_reek: nil,
        build_refinements: nil,
        build_rspec: nil,
        build_security: nil,
        build_setup: nil,
        build_simple_cov: nil,
        build_versions: nil,
        build_yard: nil,
        build_zeitwerk: nil,
        citation_affiliation: nil,
        citation_message: nil,
        citation_orcid: nil,
        documentation_format: nil,
        extensions_milestoner_documentation_format: nil,
        extensions_milestoner_prefixes: nil,
        extensions_pragmater_comments: nil,
        extensions_pragmater_includes: nil,
        extensions_tocer_label: nil,
        extensions_tocer_includes: nil,
        git_hub_user: nil,
        license_label: nil,
        license_name: nil,
        license_version: nil,
        now: nil,
        project_name: nil,
        project_url_community: nil,
        project_url_conduct: nil,
        project_url_contributions: nil,
        project_url_download: nil,
        project_url_funding: nil,
        project_url_home: nil,
        project_url_issues: nil,
        project_url_license: nil,
        project_url_security: nil,
        project_url_source: nil,
        project_url_versions: nil,
        project_version: nil,
        target_root:,
        template_path: nil,
        template_roots: [template_root],
      }
    end

    it 'answers default hash' do
      expect(described_class.new).to have_attributes(proof)
    end
  end

  describe '#add_template_roots' do
    it 'prepends single path' do
      test_root = Pathname('a/path')
      update = content.add_template_roots(test_root)

      expect(update.template_roots).to eq([test_root, template_root])
    end

    it 'prepends array of mixed paths' do
      root_a = Pathname('a/path')
      root_b = 'some/other/path'
      update = content.add_template_roots([root_a, root_b])

      expect(update.template_roots).to eq([root_a, Pathname('some/other/path'), template_root])
    end

    it "doesn't mutate itself" do
      content.add_template_roots('a/path')
      expect(content.template_roots).to eq([template_root])
    end
  end

  describe '#maximum' do
    let :proof do
      described_class[
        build_amazing_print: true,
        build_bundler_leak: true,
        build_runger_style: true,
        build_circle_ci: true,
        build_citation: true,
        build_cli: true,
        build_community: true,
        build_conduct: true,
        build_console: true,
        build_contributions: true,
        build_debug: true,
        build_funding: true,
        build_git: true,
        build_git_hub: true,
        build_git_lint: true,
        build_guard: true,
        build_license: true,
        build_maximum: true,
        build_minimum: false,
        build_rake: true,
        build_readme: true,
        build_reek: true,
        build_refinements: true,
        build_rspec: true,
        build_security: true,
        build_setup: true,
        build_simple_cov: true,
        build_versions: true,
        build_yard: true,
        build_zeitwerk: true,
        project_name: 'test',
        target_root:,
        template_roots: [template_root]
      ]
    end

    it 'disables all build options except minimum' do
      expect(content.maximize).to eq(proof)
    end

    it "doesn't mutate itself" do
      expect(content.maximize).not_to eq(content)
    end

    it 'answers as frozen' do
      expect(content.maximize).to be_frozen
    end
  end

  describe '#minimize' do
    let :proof do
      described_class[
        build_amazing_print: false,
        build_bundler_leak: false,
        build_runger_style: false,
        build_circle_ci: false,
        build_citation: false,
        build_cli: false,
        build_community: false,
        build_conduct: false,
        build_console: false,
        build_contributions: false,
        build_debug: false,
        build_funding: false,
        build_git: false,
        build_git_hub: false,
        build_git_lint: false,
        build_guard: false,
        build_license: false,
        build_maximum: false,
        build_minimum: true,
        build_rake: false,
        build_readme: false,
        build_reek: false,
        build_refinements: false,
        build_rspec: false,
        build_security: false,
        build_setup: false,
        build_simple_cov: false,
        build_versions: false,
        build_yard: false,
        build_zeitwerk: false,
        project_name: 'test',
        target_root:,
        template_roots: [template_root]
      ]
    end

    it 'disables all build options except minimum' do
      expect(content.minimize).to eq(proof)
    end

    it "doesn't mutate itself" do
      expect(content.minimize).not_to eq(content)
    end

    it 'answers as frozen' do
      expect(content.minimize).to be_frozen
    end
  end

  describe '#author_name' do
    it 'answers given and family name' do
      content = described_class[author_given_name: 'Test', author_family_name: 'Example']
      expect(content.author_name).to eq('Test Example')
    end

    it 'answers partial name when there is an empty string' do
      content = described_class[author_given_name: '', author_family_name: 'Example']
      expect(content.author_name).to eq('Example')
    end

    it 'answers given name only' do
      content = described_class[author_given_name: 'Test']
      expect(content.author_name).to eq('Test')
    end

    it 'answers family name only' do
      content = described_class[author_family_name: 'Example']
      expect(content.author_name).to eq('Example')
    end

    it "answers blank string name doesn't exist" do
      expect(content.author_name).to eq('')
    end
  end

  describe '#license_label_version' do
    it 'answers label and version' do
      content = described_class[license_label: 'Hippocratic', license_version: '3.0']
      expect(content.license_label_version).to eq('Hippocratic-3.0')
    end

    it 'answers partial label when there is an empty string' do
      content = described_class[license_label: '', license_version: '3.0']
      expect(content.license_label_version).to eq('3.0')
    end

    it 'answers label only' do
      content = described_class[license_label: 'Hippocratic']
      expect(content.license_label_version).to eq('Hippocratic')
    end

    it 'answers version only' do
      content = described_class[license_label: '3.0']
      expect(content.license_label_version).to eq('3.0')
    end

    it "answers blank string when label and version don't exist" do
      expect(content.license_label_version).to eq('')
    end
  end

  describe '#project_class' do
    it 'answers capitalized class with single project name' do
      expect(content.project_class).to eq('Test')
    end

    it 'answers camelcased class with underscored project name' do
      updated_content = content.merge(project_name: 'test_underscore')
      expect(updated_content.project_class).to eq('TestUnderscore')
    end

    it 'answers class with dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_class).to eq('Dash')
    end
  end

  describe '#project_namespaced_class' do
    it 'answers namespaced class with single project name' do
      expect(content.project_namespaced_class).to eq('Test')
    end

    it 'answers namespaced class with underscored project name' do
      updated_content = content.merge(project_name: 'test_underscore')
      expect(updated_content.project_namespaced_class).to eq('TestUnderscore')
    end

    it 'answers namespaced class with dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_namespaced_class).to eq('Test::Dash')
    end
  end

  describe '#project_label' do
    it 'answers capitalized project label with single project name' do
      expect(content.project_label).to eq('Test')
    end

    it 'answers titleized label with underscored project name' do
      updated_content = content.merge(project_name: 'test_underscore')
      expect(updated_content.project_label).to eq('Test Underscore')
    end

    it 'answers titleized project label with dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_label).to eq('Test Dash')
    end
  end

  describe '#project_levels' do
    it 'answers zero with single project name' do
      expect(content.project_levels).to eq(0)
    end

    it 'answers one with single dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_levels).to eq(1)
    end

    it 'answers more than one with multi-dashed project name' do
      updated_content = content.merge(project_name: 'test-one-two')
      expect(updated_content.project_levels).to eq(2)
    end
  end

  describe '#project_path' do
    it 'answers single project path with single project name' do
      expect(content.project_path).to eq('test')
    end

    it 'answers underscored project path with underscored project name' do
      updated_content = content.merge(project_name: 'test_underscore')
      expect(updated_content.project_path).to eq('test_underscore')
    end

    it 'answers nested project path with dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_path).to eq('test/dash')
    end
  end

  describe '#project_root' do
    it 'answers unchanged project root path with single project name' do
      expect(content.project_root).to eq(Bundler.root.join('test'))
    end

    it 'answers unchanged project root path with underscored project name' do
      updated_content = content.merge(project_name: 'test_underscore')
      expect(updated_content.project_root).to eq(Bundler.root.join('test_underscore'))
    end

    it 'answers unchanged project root path with dashed project name' do
      updated_content = content.merge(project_name: 'test-dash')
      expect(updated_content.project_root).to eq(Bundler.root.join('test-dash'))
    end
  end

  describe '#computed_project_url_community' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_community: 'test.com/%project_name%/commons')
      expect(updated_content.computed_project_url_community).to eq('test.com/test/commons')
    end
  end

  describe '#computed_project_url_conduct' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_conduct: 'test.com/%project_name%/conduct')
      expect(updated_content.computed_project_url_conduct).to eq('test.com/test/conduct')
    end
  end

  describe '#computed_project_url_contributions' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_contributions: 'test.com/%project_name%/contribs')
      expect(updated_content.computed_project_url_contributions).to eq('test.com/test/contribs')
    end
  end

  describe '#computed_project_url_download' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_download: 'test.com/%project_name%/latest')
      expect(updated_content.computed_project_url_download).to eq('test.com/test/latest')
    end
  end

  describe '#computed_project_url_funding' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_funding: 'test.com/%project_name%/funding')
      expect(updated_content.computed_project_url_funding).to eq('test.com/test/funding')
    end
  end

  describe '#computed_project_url_home' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_home: 'test.com/%project_name%')
      expect(updated_content.computed_project_url_home).to eq('test.com/test')
    end
  end

  describe '#computed_project_url_issues' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_issues: 'test.com/%project_name%/issues')
      expect(updated_content.computed_project_url_issues).to eq('test.com/test/issues')
    end
  end

  describe '#computed_project_url_license' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_license: 'test.com/%project_name%/license')
      expect(updated_content.computed_project_url_license).to eq('test.com/test/license')
    end
  end

  describe '#computed_project_url_security' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_security: 'test.com/%project_name%/security')
      expect(updated_content.computed_project_url_security).to eq('test.com/test/security')
    end
  end

  describe '#computed_project_url_source' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_source: 'test.com/%project_name%/source')
      expect(updated_content.computed_project_url_source).to eq('test.com/test/source')
    end
  end

  describe '#computed_project_url_versions' do
    it 'answers formatted URL' do
      updated_content = content.merge(project_url_versions: 'test.com/%project_name%/versions')
      expect(updated_content.computed_project_url_versions).to eq('test.com/test/versions')
    end
  end

  describe '#ascii_doc?' do
    it 'answers true when ASCII Doc format' do
      updated_content = content.merge(documentation_format: 'adoc')
      expect(updated_content.ascii_doc?).to be(true)
    end

    it 'answers false when other format' do
      updated_content = content.merge(documentation_format: 'test')
      expect(updated_content.ascii_doc?).to be(false)
    end
  end

  describe '#markdown?' do
    it 'answers true when Markdown format' do
      updated_content = content.merge(documentation_format: 'md')
      expect(updated_content.markdown?).to be(true)
    end

    it 'answers false when other format' do
      updated_content = content.merge(documentation_format: 'test')
      expect(updated_content.markdown?).to be(false)
    end
  end

  describe '#pathway' do
    it 'answers pathway' do
      expect(content.pathway).to eq(
        Rubysmith::Pathway[start_root: template_root, end_root: target_root],
      )
    end
  end

  describe '#template_root' do
    include_context 'with temporary directory'

    let(:existing_path) { temp_dir.join('a/path').make_path }
    let(:missing_path) { temp_dir.join('a/missing/path') }

    it 'answers original, existing, path' do
      expect(content.template_root).to eq(template_root)
    end

    it 'answers first existing root path' do
      content = described_class[template_roots: [missing_path, existing_path]]
      expect(content.template_root).to eq(existing_path)
    end

    it 'answers first existing full path' do
      content = described_class[
        template_roots: [missing_path, existing_path],
        template_path: 'template.rb.erb'
      ]
      existing_path.join('template.rb.erb').touch

      expect(content.template_root).to eq(existing_path)
    end

    it 'answers nil when no paths exists' do
      content = described_class[template_roots: [missing_path, missing_path]]
      expect(content.template_root).to be(nil)
    end
  end
end

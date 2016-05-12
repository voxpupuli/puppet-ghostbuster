require 'spec_helper'

ENV['HIERA_YAML_PATH'] = './spec/fixtures/hiera.yaml'

describe 'ghostbuster_hiera_files' do
  include PuppetGhostbusterSpec

  let(:code) { "" }

  context 'with fix disabled' do
    
    context 'when a certname file is NOT used' do
      let(:path) { "./hieradata/nodes/foo.example.com.yaml" }

      before :each do
        expect_puppetdb_nodes(
          [:'=', 'certname', 'foo.example.com'],
          []
        )
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("Hiera File nodes/foo.example.com.yaml seems unused")
      end
    end

    context 'when a certname file is used' do
      let(:path) { "./hieradata/nodes/bar.example.com.yaml" }

      it 'should not detect any problem' do
        expect_puppetdb_nodes(
          [:'=', 'certname', 'bar.example.com'],
          [{}]
        )
        expect(problems).to have(0).problems
      end
    end

    context 'when an environment file is NOT used' do
      let(:path) { "./hieradata/environment/foo.yaml" }

      before :each do
        expect_puppetdb_nodes(
          [:'=', ['fact', 'environment'], 'foo'],
          []
        )
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("Hiera File environment/foo.yaml seems unused")
      end
    end

    context 'when an environment file is used' do
      let(:path) { "./hieradata/environment/production.yaml" }

      it 'should not detect any problem' do
        expect_puppetdb_nodes(
          [:'=', ['fact', 'environment'], 'production'],
          [{}]
        )
        expect(problems).to have(0).problems
      end
    end

    context 'when an fact is NOT used' do
      let(:path) { "./hieradata/virtual/false.yaml" }

      before :each do
        expect_puppetdb_nodes(
          [:'=', ['fact', 'is_virtual'], 'false'],
          []
        )
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("Hiera File virtual/false.yaml seems unused")
      end
    end

    context 'when an fact file is used' do
      let(:path) { "./hieradata/virtual/true.yaml" }

      it 'should not detect any problem' do
        expect_puppetdb_nodes(
          [:'=', ['fact', 'is_virtual'], 'true'],
          [{}]
        )
        expect(problems).to have(0).problems
      end
    end

    context 'when using a variable in hierarchy' do
      let(:path) { "./hieradata/domain/example.com.yaml" }

      it 'should not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

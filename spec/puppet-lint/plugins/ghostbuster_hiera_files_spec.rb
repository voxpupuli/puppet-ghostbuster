# frozen_string_literal: true

require 'spec_helper'

ENV['HIERA_YAML_PATH'] = './spec/fixtures/hiera.yaml'

describe 'ghostbuster_hiera_files' do
  let(:code) { '' }

  context 'with fix disabled' do
    context 'when a certname file is NOT used' do
      let(:path) { './data/nodes/foo.example.com.yaml' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning("Hiera File #{path} seems unused")
      end
    end

    context 'when a certname file is used' do
      let(:path) { './data/nodes/bar.example.com.yaml' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when an environment file is NOT used' do
      let(:path) { './data/environment/foo.yaml' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning("Hiera File #{path} seems unused")
      end
    end

    context 'when an environment file is used' do
      let(:path) { './data/environment/production.yaml' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when an fact is NOT used' do
      let(:path) { './data/virtual/false.yaml' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning("Hiera File #{path} seems unused")
      end
    end

    context 'when an fact file is used' do
      let(:path) { './data/virtual/true.yaml' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when an fact file is used with wrong extension' do
      let(:path) { './data/virtual/true.eyaml' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning("Hiera File #{path} seems unused")
      end
    end

    context 'when using a variable in hierarchy' do
      let(:path) { './data/domain/example.com.yaml' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when hierarchy datadir is NOT default and NOT used' do
      let(:path) { './private/nodes/privates.example.com.eyaml' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning("Hiera File #{path} seems unused")
      end
    end

    context 'when no hiera.yaml exists' do
      let(:path) { './data/nodes/foo.example.com.yaml' }

      it {
        allow(File).to receive(:exist?).and_return(false)
        ENV.delete('HIERA_YAML_PATH')
        expect(problems.size).to eq(0)
      }
    end

    context 'when HIERA_YAML_PATH is set but does not exist' do
      let(:path) { './data/domain/example.com.yaml' }

      it {
        ENV['HIERA_YAML_PATH'] = './spec/fixtures/j.yaml'
        expect { problems }.to raise_error(Errno::ENOENT)
      }
    end
  end
end

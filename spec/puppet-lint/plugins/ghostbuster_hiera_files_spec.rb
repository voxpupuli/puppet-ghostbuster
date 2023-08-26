# frozen_string_literal: true

require 'spec_helper'

ENV['HIERA_YAML_PATH'] = './spec/fixtures/hiera.yaml'

describe 'ghostbuster_hiera_files' do
  let(:code) { '' }

  context 'with fix disabled' do
    context 'when a certname file is NOT used' do
      let(:path) { './hieradata/nodes/foo.example.com.yaml' }

      it 'detects one problem' do
        expect(problems).to have(1).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Hiera File nodes/foo.example.com.yaml seems unused')
      end
    end

    context 'when a certname file is used' do
      let(:path) { './hieradata/nodes/bar.example.com.yaml' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when an environment file is NOT used' do
      let(:path) { './hieradata/environment/foo.yaml' }

      it 'detects one problem' do
        expect(problems).to have(1).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Hiera File environment/foo.yaml seems unused')
      end
    end

    context 'when an environment file is used' do
      let(:path) { './hieradata/environment/production.yaml' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when an fact is NOT used' do
      let(:path) { './hieradata/virtual/false.yaml' }

      it 'detects one problem' do
        expect(problems).to have(1).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Hiera File virtual/false.yaml seems unused')
      end
    end

    context 'when an fact file is used' do
      let(:path) { './hieradata/virtual/true.yaml' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when using a variable in hierarchy' do
      let(:path) { './hieradata/domain/example.com.yaml' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

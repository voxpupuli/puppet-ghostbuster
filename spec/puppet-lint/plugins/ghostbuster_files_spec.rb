# frozen_string_literal: true

require 'spec_helper'

describe 'ghostbuster_files' do
  let(:code) { '' }

  context 'with fix disabled' do
    context 'when file usage is found in puppetdb' do
      let(:path) { './modules/foo/files/bar' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when parent directory with recurse => true usage is found in puppetdb' do
      let(:path) { './modules/foo/files/baz/baz' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when using full module name syntax' do
      let(:path) { './modules/foo/files/used_with_file' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when using $module_name syntax' do
      let(:path) { './modules/foo/files/used_with_file_and_module_name' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end

    context 'when file in ROOT is not used' do
      let(:path) { './modules/bar/files/foo' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('File bar/foo seems unused')
      end
    end

    context 'when file in subdir is not used' do
      let(:path) { './modules/bar/files/foo/bar' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('File bar/foo/bar seems unused')
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'ghostbuster_defines' do
  context 'with fix disabled' do
    context 'when define is not used' do
      let(:code) { 'define foo::foo {}' }
      let(:path) { './modules/foo/manifests/foo.pp' }

      it 'detects one problem' do
        expect(problems.size).to eq(1)
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Define Foo::Foo seems unused')
      end
    end

    context 'when define is used' do
      let(:code) { 'define bar::foo {}' }
      let(:path) { './modules/bar/manifests/foo.pp' }

      it 'does not detect any problem' do
        expect(problems.size).to eq(0)
      end
    end
  end
end

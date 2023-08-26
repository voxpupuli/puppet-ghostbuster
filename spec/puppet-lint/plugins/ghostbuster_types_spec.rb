# frozen_string_literal: true

require 'spec_helper'

describe 'ghostbuster_types' do
  let(:code) { '' }

  context 'with fix disabled' do
    context 'when type is not used' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/type/foo.rb' }

      it 'detects one problem' do
        expect(problems).to have(1).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Type Foo seems unused')
      end
    end

    context 'when type is used in a manifest' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/type/bar.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

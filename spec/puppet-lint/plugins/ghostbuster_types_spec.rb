require 'spec_helper'

describe 'ghostbuster_types' do
  let(:code) { '' }

  context 'with fix disabled' do

    context 'when type is not used' do
      let(:path) { "./spec/fixtures/modules/foo/lib/puppet/type/foo.rb" }

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("Type Foo seems unused")
      end
    end

    context 'when type is used in a manifest' do
      let(:path) { "./spec/fixtures/modules/foo/lib/puppet/type/bar.rb" }

      it 'should not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

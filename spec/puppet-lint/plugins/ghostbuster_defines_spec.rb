require 'spec_helper'

describe 'ghostbuster_defines' do

  context 'with fix disabled' do

    context 'when define is not used' do
      let(:code) { "define foo::foo {}" }
      let(:path) { "./modules/foo/manifests/foo.pp" }

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning('Define Foo::Foo seems unused')
      end
    end

    context 'when define is used' do
      let(:code) { "define bar::foo {}" }
      let(:path) { "./modules/bar/manifests/foo.pp" }

      it 'should not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

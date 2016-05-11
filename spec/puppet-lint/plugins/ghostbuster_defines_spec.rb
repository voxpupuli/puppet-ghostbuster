require 'spec_helper'

describe 'ghostbuster_defines' do
  include PuppetGhostbusterSpec

  context 'with fix disabled' do

    context 'when define is used' do
      let(:code) { "define foo {}" }
      let(:path) { "./modules/foo/manifests/init.pp" }

      it 'should not detect any problem' do
        expect_puppetdb([:'=', 'type', 'Foo'], [{}])
        expect(problems).to have(0).problems
      end
    end

    context 'when define is not used' do
      let(:code) { "define bar {}" }
      let(:path) { "./modules/bar/manifests/init.pp" }

      before :each do
        expect_puppetdb([:'=', 'type', 'Bar'], [])
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning('Define Bar seems unused')
      end
    end
  end
end

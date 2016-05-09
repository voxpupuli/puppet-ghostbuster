require 'spec_helper'

class PuppetDBRequest
  def initialize(data)
    @data = data
  end

  def data
    @data
  end
end

describe 'ghostbuster_defines' do
  let(:path) { "./modules/foo/manifests/init.pp" }

  context 'with fix disabled' do

    context 'when define is used' do
      let(:code) { "define foo {}" }

      before :each do
        expect_any_instance_of(PuppetDB::Client).to \
          receive(:request).with('resources', [:'=', 'type', 'Foo'])
          .and_return(PuppetDBRequest.new([
        {
          'type' => 'Foo',
          'title' => 'bar',
        },
        ]))
      end

      it 'should not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when define is not used' do
      let(:code) { "define foo {}" }

      before :each do
        expect_any_instance_of(PuppetDB::Client).to \
          receive(:request).with('resources', [:'=', 'type', 'Foo'])
          .and_return(PuppetDBRequest.new([]))
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning('Define Foo seems unused')
      end
    end
  end
end

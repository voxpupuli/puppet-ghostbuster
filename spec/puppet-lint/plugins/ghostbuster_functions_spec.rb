require 'spec_helper'

describe 'ghostbuster_functions' do
  let(:code) { '' }

  context 'with fix disabled' do
    context 'when function is not used' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/parser/functions/foo.rb' }

      it 'detects one problem' do
        expect(problems).to have(1).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Function foo seems unused')
      end
    end

    context 'when function is used in a manifest' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/parser/functions/bar.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when function is used in a template using scope.function_baz()' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/parser/functions/baz.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when function is used in a template using Puppet::Parser::Functions.function(:quux)' do
      let(:path) { './spec/fixtures/modules/foo/lib/puppet/parser/functions/quux.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

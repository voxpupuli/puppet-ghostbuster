require 'spec_helper'

describe 'ghostbuster_facts' do
  let(:code) { "Facter.add('foo')" }

  context 'with fix disabled' do
    context 'when fact is not used' do
      let(:path) { './spec/fixtures/modules/foo/lib/facter/multi.rb' }

      it 'detects one problem' do
        expect(problems).to have(2).problems
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Fact multi1 seems unused')
      end

      it 'creates a warning' do
        expect(problems).to contain_warning('Fact multi2 seems unused')
      end
    end

    context 'when fact is used in a string' do
      let(:path) { './spec/fixtures/modules/foo/lib/facter/foo.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when fact is used in manifest' do
      let(:path) { './spec/fixtures/modules/foo/lib/facter/bar.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when fact is used in a template' do
      let(:path) { './spec/fixtures/modules/foo/lib/facter/baz.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when fact is used in an inline_template' do
      let(:path) { './spec/fixtures/modules/foo/lib/facter/quux.rb' }

      it 'does not detect any problem' do
        expect(problems).to have(0).problems
      end
    end
  end
end

require 'spec_helper'

describe 'ghostbuster_templates' do
  let(:path) { "./modules/foo/templates/bar" }
  let(:code) { "" }

  context 'with fix disabled' do

    context 'when template usage is found in manifests' do

      before :each do
        subject.stub(:manifests).and_return(["./manifests/site.pp"])
      end

      context 'when using full module name syntax' do
        it 'should not detect any problem' do
          pending 'how to stub :manifests???'
          expect(problems).to have(0).problems
        end
      end

      context 'when using $module_name syntax' do
        it 'should not detect any problem' do
          pending 'how to stub :manifests???'
          expect(problems).to have(0).problems
        end
      end
    end

    context 'when template usage is not found in manifests' do
      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("Template foo/bar seems unused")
      end
    end
  end
end

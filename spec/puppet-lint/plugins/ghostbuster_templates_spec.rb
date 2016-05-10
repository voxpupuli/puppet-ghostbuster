require 'spec_helper'

describe 'ghostbuster_templates' do
  let(:path) { "./modules/foo/templates/bar" }
  let(:code) { "" }

  context 'with fix disabled' do

    context 'when template usage is found in manifests' do

      before :each do
        Dir.stub(:glob){["./modules/foo/manifests/bar.pp" ]}
      end

      context 'when using full module name syntax' do
        it 'should not detect any problem' do
          expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", "  content => template('foo/bar'),", "  }"])
          expect(problems).to have(0).problems
        end
      end

      context 'when using $module_name syntax' do
        it 'should not detect any problem' do
          expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", "  content => template('bar/foo'),", "  }"])
          expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", '  content => template("${module_name}/bar"),', "  }"])
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

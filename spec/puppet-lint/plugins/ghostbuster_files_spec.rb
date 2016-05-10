require 'spec_helper'

describe 'ghostbuster_files' do
  let(:path) { "./modules/foo/files/bar/baz" }
  let(:code) { "" }

  context 'with fix disabled' do

    context 'when file usage is found in puppetdb' do

      before :each do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar/baz"],
        )
          .and_return(PuppetDBRequest.new([{}]))
      end

      it 'should not detect any problem' do
        expect(problems).to have(0).problems
      end
    end

    context 'when file usage is not found in puppetdb' do

      before :each do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar/baz"],
        )
          .and_return(PuppetDBRequest.new([]))
      end

      context 'when parent directory with recurse => true usage is found in puppetdb' do
        before :each do
          expect_any_instance_of(PuppetDB::Client).to \
            receive(:request).with(
              'resources',
              [:'and',
               [:'or',
                [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar"],
                [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar/"],
          ],
          [:'=', ['parameter', 'recurse'], true],
          ],
          )
            .and_return(PuppetDBRequest.new([
          {
          },
          ]))
        end

        it 'should not detect any problem' do
          expect(problems).to have(0).problems
        end
      end

      context 'when parent directory usage is not found in puppetdb' do
        before :each do
          expect_any_instance_of(PuppetDB::Client).to \
            receive(:request).with(
              'resources',
              [:'and',
               [:'or',
                [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar"],
                [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar/"],
          ],
          [:'=', ['parameter', 'recurse'], true],
          ],
          )
            .and_return(PuppetDBRequest.new([]))
        end

        context 'when file usage is found in manifests' do

          before :each do
            Dir.stub(:glob){["./modules/foo/manifests/bar.pp" ]}
          end

          context 'when using full module name syntax' do
            it 'should not detect any problem' do
              expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", "  content => file('foo/bar/baz'),", "  }"])
              expect(problems).to have(0).problems
            end
          end

          context 'when using $module_name syntax' do
            it 'should not detect any problem' do
              expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", "  content => file('bar/foo'),", "  }"])
              expect(File).to receive(:readlines).with("./modules/foo/manifests/bar.pp").and_return(["file{'foo':", '  content => file("${module_name}/bar/baz"),', "  }"])
              expect(problems).to have(0).problems
            end
          end
        end

        context 'when file usage is not found in manifests' do
          it 'should detect one problem' do
            expect(problems).to have(1).problems
          end

          it 'should create a warning' do
            expect(problems).to contain_warning("File foo/bar/baz seems unused")
          end
        end
      end
    end
  end
end

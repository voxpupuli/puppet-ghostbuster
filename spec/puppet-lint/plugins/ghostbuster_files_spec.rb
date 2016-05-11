require 'spec_helper'

describe 'ghostbuster_files' do
  let(:code) { "" }

  context 'with fix disabled' do

    context 'when file usage is found in puppetdb' do
      let(:path) { "./modules/foo/files/bar" }

      it 'should not detect any problem' do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar"],
        )
          .and_return(PuppetDBRequest.new([{}]))
        expect(problems).to have(0).problems
      end
    end

    context 'when parent directory with recurse => true usage is found in puppetdb' do
      let(:path) { "./modules/foo/files/bar/baz" }

      it 'should not detect any problem' do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/bar/baz"],
        )
          .and_return(PuppetDBRequest.new([]))
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
          .and_return(PuppetDBRequest.new([{}]))
        expect(problems).to have(0).problems
      end
    end

    context 'when using full module name syntax' do
      let(:path) { "./modules/foo/files/used_with_file" }

      it 'should not detect any problem' do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/used_with_file"],
        )
          .and_return(PuppetDBRequest.new([]))
        expect(problems).to have(0).problems
      end
    end

    context 'when using $module_name syntax' do
      let(:path) { "./modules/foo/files/used_with_file_and_module_name" }

      it 'should not detect any problem' do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/foo/used_with_file_and_module_name"],
        )
          .and_return(PuppetDBRequest.new([]))
        expect(problems).to have(0).problems
      end
    end

    context 'when file in ROOT is not used' do
      let(:path) { "./modules/bar/files/foo" }

      before :each do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/bar/foo"],
        )
          .and_return(PuppetDBRequest.new([]))
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("File bar/foo seems unused")
      end
    end

    context 'when file in subdir is not used' do
      let(:path) { "./modules/bar/files/foo/bar" }

      before :each do
        expect_any_instance_of(PuppetDB::Client).to\
          receive(:request).with(
            'resources',
            [:'=', ['parameter', 'source'], "puppet:///modules/bar/foo/bar"],
        )
          .and_return(PuppetDBRequest.new([]))
        expect_any_instance_of(PuppetDB::Client).to \
          receive(:request).with(
            'resources',
            [:'and',
             [:'or',
              [:'=', ['parameter', 'source'], "puppet:///modules/bar/foo"],
              [:'=', ['parameter', 'source'], "puppet:///modules/bar/foo/"],
        ],
        [:'=', ['parameter', 'recurse'], true],
        ],
        )
          .and_return(PuppetDBRequest.new([]))
      end

      it 'should detect one problem' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning("File bar/foo/bar seems unused")
      end
    end
  end
end

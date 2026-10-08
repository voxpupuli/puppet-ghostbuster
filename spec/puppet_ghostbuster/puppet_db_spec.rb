# frozen_string_literal: true

require 'spec_helper'

describe PuppetGhostbuster::PuppetDB do
  describe '.server_url' do
    around do |example|
      original_url = ENV.fetch('PUPPETDB_URL', nil)
      ENV.delete('PUPPETDB_URL')
      example.run
    ensure
      if original_url
        ENV['PUPPETDB_URL'] = original_url
      else
        ENV.delete('PUPPETDB_URL')
      end
    end

    it 'uses the explicit URL without loading the PuppetDB integration' do
      ENV['PUPPETDB_URL'] = 'https://database.example.com:8081'
      allow(described_class).to receive(:require)
      expect(described_class.server_url).to eq('https://database.example.com:8081')
      expect(described_class).not_to have_received(:require)
    end

    it 'uses the first URL from the PuppetDB integration' do
      config = Struct.new(:server_urls).new(['https://database.example.com:8081'])
      integration = Struct.new(:config).new(config)
      stub_const('Puppet::Util::Puppetdb', integration)
      allow(described_class).to receive(:require).with('puppet/util/puppetdb')
      expect(described_class.server_url).to eq('https://database.example.com:8081')
    end

    context 'without the PuppetDB integration' do
      before do
        allow(described_class).to receive(:require).with('puppet/util/puppetdb').and_raise(LoadError)
      end

      it 'uses the configured Puppet server' do
        allow(Puppet).to receive(:[]).with(:server).and_return('compiler.example.com')
        expect(described_class.server_url).to eq('https://compiler.example.com:8081')
      end

      it 'reports a missing server instead of constructing an invalid URL' do
        allow(Puppet).to receive(:[]).with(:server).and_return('')
        expect { described_class.server_url }.to raise_error(ArgumentError, /Set PUPPETDB_URL/)
      end

      it 'treats an empty explicit URL as unset' do
        ENV['PUPPETDB_URL'] = ''
        allow(Puppet).to receive(:[]).with(:server).and_return('compiler.example.com')
        expect(described_class.server_url).to eq('https://compiler.example.com:8081')
      end
    end
  end
end

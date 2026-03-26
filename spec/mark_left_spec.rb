# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MarkLeft do
  describe '.convert' do
    it 'converts markdown using default configuration' do
      expect(described_class.convert('# Heading')).to eq('h3. Heading')
    end

    it 'accepts per-call header_level override' do
      expect(described_class.convert('# Heading', header_level: 'h1')).to eq('h1. Heading')
    end

    it 'accepts per-call list_depth override' do
      expect(described_class.convert('- item', list_depth: 1)).to eq('* item')
    end
  end

  describe '.configure' do
    after { described_class.configuration = nil }

    before do
      described_class.configure do |config|
        config.header_level = 'h1'
        config.list_depth = 1
      end
    end

    it 'applies configured header_level globally' do
      expect(described_class.convert('# Heading')).to eq('h1. Heading')
    end

    it 'applies configured list_depth globally' do
      expect(described_class.convert('- item')).to eq('* item')
    end

    it 'allows per-call header_level to override global config' do
      expect(described_class.convert('# Heading', header_level: 'h2')).to eq('h2. Heading')
    end

    it 'allows per-call list_depth to override global config' do
      expect(described_class.convert('- item', list_depth: 2)).to eq('** item')
    end
  end

  describe MarkLeft::Configuration do
    subject(:config) { described_class.new }

    it 'defaults header_level to h3' do
      expect(config.header_level).to eq('h3')
    end

    it 'defaults list_depth to 3' do
      expect(config.list_depth).to eq(3)
    end

    it 'allows header_level to be changed' do
      config.header_level = 'h1'
      expect(config.header_level).to eq('h1')
    end

    it 'allows list_depth to be changed' do
      config.list_depth = 1
      expect(config.list_depth).to eq(1)
    end

    it 'raises InvalidHeaderLevelError for an invalid header_level' do
      expect { config.header_level = 'h7' }.to raise_error(Markdown::ToTextile::InvalidHeaderLevelError)
    end

    it 'raises InvalidHeaderLevelError for a non-string header_level' do
      expect { config.header_level = 3 }.to raise_error(Markdown::ToTextile::InvalidHeaderLevelError)
    end

    it 'raises InvalidListDepthError for zero list_depth' do
      expect { config.list_depth = 0 }.to raise_error(Markdown::ToTextile::InvalidListDepthError)
    end

    it 'raises InvalidListDepthError for a non-integer list_depth' do
      expect { config.list_depth = 'x' }.to raise_error(Markdown::ToTextile::InvalidListDepthError)
    end
  end
end

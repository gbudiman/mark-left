# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MarkLeft::ToTextile do
  subject(:converter) { described_class.new }

  let(:input) do
    <<~MD
      # **Title**

      - item one
      - **item two**
        - nested with **bold**

      1. **first**
      1. second
    MD
  end

  let(:output) do
    <<~TEXTILE
      h3. *Title*

      *** item one
      *** *item two*
      **** nested with *bold*

      # *first*
      # second
    TEXTILE
  end

  it 'raises InvalidHeaderLevelError for an invalid header_level' do
    expect { described_class.new(header_level: 'h7') }.to raise_error(MarkLeft::ToTextile::InvalidHeaderLevelError)
  end

  it 'raises InvalidHeaderLevelError for a non-string header_level' do
    expect { described_class.new(header_level: 3) }.to raise_error(MarkLeft::ToTextile::InvalidHeaderLevelError)
  end

  it 'raises InvalidListDepthError for zero list_depth' do
    expect { described_class.new(list_depth: 0) }.to raise_error(MarkLeft::ToTextile::InvalidListDepthError)
  end

  it 'raises InvalidListDepthError for negative list_depth' do
    expect { described_class.new(list_depth: -1) }.to raise_error(MarkLeft::ToTextile::InvalidListDepthError)
  end

  it 'raises InvalidListDepthError for non-integer list_depth' do
    expect { described_class.new(list_depth: 'x') }.to raise_error(MarkLeft::ToTextile::InvalidListDepthError)
  end

  it 'returns empty string for nil input' do
    expect(converter.convert(nil)).to eq('')
  end

  it 'converts numeric input to string' do
    expect(converter.convert(42)).to eq('42')
  end

  it 'converts bold inside a list item' do
    expect(converter.convert('- **bold** text')).to eq('*** *bold* text')
  end

  it 'converts bold inside a header' do
    expect(converter.convert('# **Bold** header')).to eq('h3. *Bold* header')
  end

  it 'converts a full document' do
    expect(converter.convert(input)).to eq(output)
  end
end

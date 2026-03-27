# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MarkLeft::ToTextile::Header do
  it 'converts h1' do
    expect(described_class.execute('# Heading', header_level: 'h3')).to eq('h3. Heading')
  end

  it 'converts h2' do
    expect(described_class.execute('## Heading', header_level: 'h3')).to eq('h3. Heading')
  end

  it 'converts h6' do
    expect(described_class.execute('###### Heading', header_level: 'h3')).to eq('h3. Heading')
  end

  it 'respects a custom header level' do
    expect(described_class.execute('## Heading', header_level: 'h1')).to eq('h1. Heading')
  end

  it 'requires a space after # to match' do
    expect(described_class.execute('#Heading', header_level: 'h3')).to eq('#Heading')
  end

  it 'leaves non-header lines unchanged' do
    expect(described_class.execute('plain text', header_level: 'h3')).to eq('plain text')
  end
end

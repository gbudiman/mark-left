# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Markdown::ToTextile::Bold do
  it 'converts **text**' do
    expect(described_class.execute('**bold**')).to eq('*bold*')
  end

  it 'converts __text__' do
    expect(described_class.execute('__bold__')).to eq('*bold*')
  end

  it 'converts multiple bold spans on one line' do
    expect(described_class.execute('**a** and **b**')).to eq('*a* and *b*')
  end

  it 'leaves plain text unchanged' do
    expect(described_class.execute('plain text')).to eq('plain text')
  end
end

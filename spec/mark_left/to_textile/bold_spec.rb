# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MarkLeft::ToTextile::Bold do
  it 'converts **text**' do
    expect(described_class.execute('**bold**')).to eq('*bold*')
  end

  it 'converts __text__' do
    expect(described_class.execute('__bold__')).to eq('*bold*')
  end

  it 'converts multiple bold spans on one line' do
    expect(described_class.execute('**a** and **b**')).to eq('*a* and *b*')
  end

  it 'converts mixed delimiters on the same line' do
    expect(described_class.execute('**a** and __b__')).to eq('*a* and *b*')
  end

  it 'preserves single space inside bold' do
    expect(described_class.execute('**hello world**')).to eq('*hello world*')
  end

  it 'preserves multiple spaces inside bold' do
    expect(described_class.execute('**hello  world**')).to eq('*hello  world*')
  end

  it 'preserves leading and trailing spaces inside bold' do
    expect(described_class.execute('**  hello  **')).to eq('*  hello  *')
  end

  it 'leaves plain text unchanged' do
    expect(described_class.execute('plain text')).to eq('plain text')
  end
end

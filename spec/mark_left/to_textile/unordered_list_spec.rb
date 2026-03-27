# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MarkLeft::ToTextile::UnorderedList do
  it 'uses triple asterisks by default for a depth-1 item' do
    expect(described_class.execute('- item')).to eq('*** item')
  end

  it 'uses triple asterisks by default for a depth-2 item (2-space indent)' do
    expect(described_class.execute('  - nested')).to eq('**** nested')
  end

  it 'uses triple asterisks by default for a depth-3 item (4-space indent)' do
    expect(described_class.execute('    - deep')).to eq('***** deep')
  end

  it 'respects a custom list_depth' do
    expect(described_class.execute('- item', list_depth: 1)).to eq('* item')
  end

  it 'respects a custom list_depth for nested items' do
    expect(described_class.execute('  - nested', list_depth: 1)).to eq('** nested')
  end

  it 'treats 1-space indent the same as no indent (floor division)' do
    expect(described_class.execute(' - item')).to eq('*** item')
  end

  it 'leaves non-list lines unchanged' do
    expect(described_class.execute('plain text')).to eq('plain text')
  end
end

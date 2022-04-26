require 'rspec'
require './lib/item'

describe Item do
  it 'exists with attributes' do
    item = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    expect(item.name).to eq('Peach Pie (Slice)')
    expect(item.price).to eq(3.75)
  end
end

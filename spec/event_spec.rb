require 'rspec'
require './lib/item'
require './lib/food_truck'
require './lib/event'

describe Event do
  it 'exists with attributes' do
    event = Event.new('South Pearl Street Farmers Market')
    expect(event).to be_a(Event)
    expect(event.name).to eq('South Pearl Street Farmers Market')
    expect(event.food_trucks).to eq([])
  end

  it 'can add foot trucks' do
    event = Event.new('South Pearl Street Farmers Market')
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    expect(event.food_trucks).to eq([])
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)
    expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
  end

  it 'can return an array of food truck names that have been added' do
    event = Event.new('South Pearl Street Farmers Market')
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)
    expected = ['Rocky Mountain Pies', 'Ba-Nom-a-Nom', 'Palisade Peach Shack']
    expect(event.food_truck_names).to eq(expected)
  end

  it 'can return an array of trucks that sell an item' do
    event = Event.new('South Pearl Street Farmers Market')
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    food_truck3.stock(item1, 65)
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)
    expected = [food_truck1, food_truck3]
    expect(event.food_trucks_that_sell(item1)).to eq(expected)
    expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
  end

  it 'can return a list of all items sorted alphabetically by name' do
    event = Event.new('South Pearl Street Farmers Market')
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    food_truck3.stock(item1, 65)
    food_truck3.stock(item3, 10)
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)
    expected = [item2, item4, item1, item3]
    expect(event.sorted_item_list).to eq(expected)
  end

  it 'can return an array of all overstocked items' do
    event = Event.new('South Pearl Street Farmers Market')
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    food_truck3.stock(item1, 65)
    food_truck3.stock(item3, 10)
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)
    expect(event.overstocked_items).to eq([item1])
  end
end

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
end

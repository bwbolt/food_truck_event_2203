require 'date'

class Event
  attr_reader :name, :food_trucks, :date

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today.strftime '%d/%m/%Y'
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.inventory.keys.include?(item) }
  end

  def sorted_item_list
    items = @food_trucks.map { |truck| truck.inventory.keys }.flatten.uniq
    items.sort_by { |item| item.name }
  end

  def overstocked_items
    total_inventory.select do |_item, info|
      info[:quantity] > 50 && info[:food_trucks].length > 1
    end.keys
  end

  def total_inventory
    items = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, amount|
        if items[item].nil?
          items[item] = { quantity: amount, food_trucks: [truck] }
        else
          items[item][:quantity] += amount
          items[item][:food_trucks] << truck
        end
      end
    end
    items
  end

  def sell(item, amount)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < amount
      false
    else
      sell_by_truck(item, amount)
      true
    end
  end

  def sell_by_truck(item, amount)
    total_left = amount
    until total_left == 0
      @food_trucks.each do |truck|
        if truck.inventory[item] <= total_left
          total_left -= truck.inventory[item]
          truck.sell_item(item, truck.inventory[item])
        else
          truck.sell_item(item, total_left)
          total_left -= total_left
        end
      end
    end
  end
end

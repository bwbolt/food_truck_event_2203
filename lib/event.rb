class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
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
end

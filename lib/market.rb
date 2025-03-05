require 'date'
class Market
    attr_reader :name, :vendors
    def initialize(name)
        @name = name
        @vendors = []
        @date = Date.today
        #require 'pry'; binding.pry
    end
    
    def date
        @date.strftime("%d/%m/%Y")
    end

    def add_vendor(vendor)
        @vendors << vendor
    end

    def vendor_names
        names = []
        @vendors.each do |vendor|
            names << vendor.name
        end
        names
    end

    def vendors_that_sell(item)
        results = []
        @vendors.each do |vendor|
            if vendor.check_stock(item) > 0
                results << vendor
            end
        end
        results
    end

    def total_inventory
        results = {}
        
        @vendors.each do |vendor| #iterates through every vendor
            vendor.inventory.map do |item,stock| #iterates through every vendor's inventory, one item at a time
                if results[item] == nil
                    results[item] = {quantity: 0}
                end

                results[item][:quantity] += stock

                results[item][:vendors] = vendors_that_sell(item)       
            end   
        end
        results
    end

    def overstocked_items
        inventory = total_inventory
        overstocked = []
        inventory.each do |item,info|
            if info[:quantity] > 50 && info[:vendors].length > 1
                overstocked << item
            end
        end
        overstocked
    end
    
    def sorted_item_list
        list = []
        inventory = total_inventory
        inventory.each do |item,info|
            list << item.name
            
        end
        list.sort.uniq
    end
end
#require 'pry'; binding.pry
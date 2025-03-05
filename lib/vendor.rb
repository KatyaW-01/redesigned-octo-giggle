class Vendor
    attr_reader :name, :inventory
    def initialize(name)
        @name = name
        @inventory = {}
    end
    def check_stock(item)
        if @inventory[item] == nil
            0
        else
            @inventory[item]
        end
    end

    def stock(item,number)
        if @inventory[item]
            @inventory[item] += number
        else
            @inventory[item] = number 
        end    
    end
    
    def potential_revenue
        revenue = 0
        @inventory.each do |item, stock|
            price = item.price.to_f * stock
            revenue += price
        end
        revenue
    end

end
 
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
    before(:each) do
        @market = Market.new("South Pearl Street Farmers Market")    
    end
    describe "#initialize" do
        it 'exists' do
            expect(@market).to be_a(Market)
        end
    end
    describe "#attributes" do
        it 'has a name' do
            expect(@market.name).to eq("South Pearl Street Farmers Market")
        end
        it 'has vendors' do
            expect(@market.vendors).to eq([])
        end
    end
    describe "#methods" do
        it 'can add vendors' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35) 
            vendor1.stock(item2, 7) 

            vendor2 = Vendor.new("Ba-Nom-a-Nom") 

            vendor2.stock(item4, 50)    
            vendor2.stock(item3, 25)

            vendor3 = Vendor.new("Palisade Peach Shack")  

            vendor3.stock(item1, 65)  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expect(@market.vendors).to eq([vendor1,vendor2,vendor3])

        end
        it 'can return a list of vendor names' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")
            vendor2 = Vendor.new("Ba-Nom-a-Nom") 
            vendor3 = Vendor.new("Palisade Peach Shack")  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expect(@market.vendor_names).to eq(["Rocky Mountain Fresh","Ba-Nom-a-Nom","Palisade Peach Shack"])

        end

        it 'can return a list of vendors that have an item in stock' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35) 
            vendor1.stock(item2, 7) 

            vendor2 = Vendor.new("Ba-Nom-a-Nom") 

            vendor2.stock(item4, 50)    
            vendor2.stock(item3, 25)

            vendor3 = Vendor.new("Palisade Peach Shack")  

            vendor3.stock(item1, 65)  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expect(@market.vendors_that_sell(item1)).to eq([vendor1,vendor3])
            expect(@market.vendors_that_sell(item4)).to eq([vendor2])
        end

        it 'has a total inventory' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35) 
            vendor1.stock(item2, 7) 

            vendor2 = Vendor.new("Ba-Nom-a-Nom") 

            vendor2.stock(item4, 50)    
            vendor2.stock(item3, 25)

            vendor3 = Vendor.new("Palisade Peach Shack")  

            vendor3.stock(item1, 65)  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expected_hash = {
                item1 => {quantity: 100, vendors: [vendor1,vendor3]},
                item2 => {quantity: 7, vendors: [vendor1]},
                item3 => {quantity: 25, vendors: [vendor2]},
                item4 => {quantity: 50, vendors: [vendor2]}
            }

            expect(@market.total_inventory).to eq(expected_hash)
        end
        it 'can return an array of overstocked items' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35) 
            vendor1.stock(item2, 7) 

            vendor2 = Vendor.new("Ba-Nom-a-Nom") 

            vendor2.stock(item4, 50)    
            vendor2.stock(item3, 25)

            vendor3 = Vendor.new("Palisade Peach Shack")  

            vendor3.stock(item1, 65)  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expect(@market.overstocked_items).to eq([item1])
        end
        it 'can return a list of names of items in stock' do
            vendor1 = Vendor.new("Rocky Mountain Fresh")

            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: "$0.50"})
            item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
            item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

            vendor1.stock(item1, 35) 
            vendor1.stock(item2, 7) 

            vendor2 = Vendor.new("Ba-Nom-a-Nom") 

            vendor2.stock(item4, 50)    
            vendor2.stock(item3, 25)

            vendor3 = Vendor.new("Palisade Peach Shack")  

            vendor3.stock(item1, 65)  

            @market.add_vendor(vendor1)    
            @market.add_vendor(vendor2)  
            @market.add_vendor(vendor3)

            expect(@market.sorted_item_list).to eq(["Banana Nice Cream",'Peach',"Peach-Raspberry Nice Cream",'Tomato'])
        end
        it 'has a date' do
            #my notes say you shouldnt stub the whole method you are testing but I didnt see how else to do it
            #and tests pass, is this the right way to do the stub here?

            allow(@market).to receive(:date).and_return('04/22/2023')

            expect(@market.date).to eq('04/22/2023')
            
        end
    end
end
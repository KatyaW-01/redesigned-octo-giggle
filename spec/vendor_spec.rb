require './lib/vendor'
require './lib/item'

RSpec.describe Vendor do
    before(:each) do
        @vendor = Vendor.new("Rocky Mountain Fresh")
    end
    describe "#initialize" do
        it 'exists' do
            expect(@vendor).to be_a(Vendor)
        end
    end
    describe "#attributes" do
        it 'has a name' do
            expect(@vendor.name).to eq("Rocky Mountain Fresh")
        end
        it 'has inventory' do
            expect(@vendor.inventory).to eq({})
        end
    end
    describe "#methods" do
        it 'can check stock in invnetory' do
            item1 = Item.new({name: 'Peach', price: "$0.75"})
            
            expect(@vendor.check_stock(item1)).to eq(0)
        end
        it 'can stock items' do
            item1 = Item.new({name: 'Peach', price: "$0.75"})
            item2 = Item.new({name: 'Tomato', price: '$0.50'})

            @vendor.stock(item1, 30)

            expect(@vendor.inventory).to eq({item1 => 30})
            expect(@vendor.check_stock(item1)).to eq(30)

            @vendor.stock(item1, 25)

            expect(@vendor.inventory).to eq({item1 => 55})

            @vendor.stock(item2, 12)

            expect(@vendor.inventory).to eq({item1 => 55, item2 => 12})

        end
        it 'has potential revenue' do
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

            expect(vendor1.potential_revenue).to eq(29.75)
            expect(vendor2.potential_revenue).to eq(345.00)
            expect(vendor3.potential_revenue).to eq(48.75)
        end
       
    end
end
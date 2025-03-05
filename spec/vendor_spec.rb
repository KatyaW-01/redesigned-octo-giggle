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
    end
end
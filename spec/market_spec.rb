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
end
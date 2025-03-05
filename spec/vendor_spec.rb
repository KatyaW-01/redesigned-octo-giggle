require './lib/vendor'

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
end
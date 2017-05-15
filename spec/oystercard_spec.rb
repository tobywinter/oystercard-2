require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it "returns a value for the balance" do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 10
    end
  end

end

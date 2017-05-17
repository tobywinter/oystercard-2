require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it "returns a value for the balance" do
      expect(oystercard.balance).to eq 0
    end

    it "Increases the balance when top_up is called" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it "errors if a maximum balance is reached" do
      expect{ oystercard.top_up(91) }.to raise_error "Cannot top_up above #{oystercard.class::Maximum_balance}"
    end

    it "Decreases the balance when deduct_fare is called" do
      expect{oystercard.touch_out(oystercard.class::Minimum_fare)}.to change{ oystercard.balance }.by -1
    end
  end

  describe '#in_journey?' do
    it "initializes oystercards with a default value of 'ready_to_use'" do
      expect(oystercard.in_journey?).to eq false
    end

    it "Will not allow a user to touch in when card balance is below minimum fare" do
    expect{ oystercard.touch_in(:station) }.to raise_error "Insufficient funds"
  end

    it "shows the oystercard as in_journey after touch_in" do
      oystercard.top_up(1)
      oystercard.touch_in(:station)
      expect(oystercard.in_journey?).to eq true
    end

    it "shows the oystercard as !in_journey after touch_out" do
      oystercard.touch_out(0)
      expect(oystercard.in_journey?).to eq false
    end

    it "Charges the card the fare upon touch out" do
      expect {oystercard.touch_out(oystercard.class::Minimum_fare)}.to change{oystercard.balance}.by(-oystercard.class::Minimum_fare)
    end
  end
  let(:station) { double(:station) }
  describe '#journey log' do
    it 'tells you where you have touched in' do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      expect(oystercard.entry_station).to eq :station
    end
    it "Clears the entry_station on touch_out" do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      oystercard.touch_out(oystercard.class::Minimum_fare)
      expect(oystercard.entry_station).to eq nil
    end
    it "Return a log of our journeys" do
      oystercard.top_up(10)
        oystercard.touch_in(:entry_station)
        oystercard.touch_out(oystercard.class::Minimum_fare, :exit_station)
      expect(oystercard.journey_log).to eq [{entry_station: :entry_station, exit_station: :exit_station}]
      end
    end
  end

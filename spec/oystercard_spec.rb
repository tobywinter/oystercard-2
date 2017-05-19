require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new(50)}

  let(:entry_station) {double(:entry_station) }
  let(:exit_station) { double(:station) }
  let(:fake_journey) { double(:journey) }
  it 'expects balance to be 0' do
    card = described_class.new(0)
    expect(card.balance).to eq (0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'updates the balance when we top up' do
      card = described_class.new(0)
      card.top_up(5)
      expect(card.balance).to eq 5
    end
    it 'raises an error when top up exceeds £90' do
      card = described_class.new(0)
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up(1) }.to raise_error "Balance exceeded #{maximum_balance}"
    end
  end


  describe '#deduct' do
    it 'deducts fare from the balance' do
      card = described_class.new(0)
      card.top_up(20)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.balance).to eq 20 - Fare::MIN_FARE
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
    expect(card.touch_in(:entry_station)).to eq card
    end

    it 'raises an error when balance below minimum fare' do
      card = described_class.new(0)
      expect{ card.touch_in (:entry_station)}.to raise_error "Balance below minimum fare"
    end
  end


  describe '#touch_out' do

    it 'deduct minimum fare' do
      card = described_class.new(0)
      card.top_up(40)
      expect{ card.touch_in(:entry_station).touch_out(:exit_station) }.to change{ card.balance }.by(-Fare::MIN_FARE)
    end

    it 'adds a journey to the journeys list' do
      card.touch_out(:exit_station)
      expect{ card.touch_out(:exit_station) }.to change{ card.journey_log.length }.by(+1)
    end

  end

  describe "#journey_log" do
    it 'Tests that the card has list of empty journies when created' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      expect(card.journey_log).to eq []
    end
    it 'tests that checks that touching in and out creates one journey' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.journey_log).to eq [card.last_journey]
    end
  end
end

require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new(50)}

  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

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
      card.touch_out(:exit_station)
      expect(card.balance).to eq 20 - Fare::MIN_FARE
    end
  end

  it { is_expected.to respond_to(:in_journey?) }

  describe '#in_journey' do
    it 'returns false when new oystercard is created' do
      expect(card.in_journey?).to eq false
    end
  end

  it { is_expected.to respond_to(:touch_in) }

  describe '#touch_in' do
    it 'can touch in' do
    # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
    card.touch_in(:entry_station)
    expect(card.in_journey?).to eq true
    end

    it 'raises an error when balance below minimum fare' do
      card = described_class.new(0)
      expect{ card.touch_in (:entry_station)}.to raise_error "Balance below minimum fare"
    end

    it 'records the touch_in station' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(:entry_station)
      expect(card.entry_station).to eq (:entry_station)
    end

  end

  it { is_expected.to respond_to(:touch_out) }
  describe '#touch_out' do
    it 'can touch out' do
    # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
    card.touch_in(:entry_station)
    card.touch_out(:exit_station)
    expect(card.in_journey?).to eq false
    end

    it 'deduct minimun fare' do
      card = described_class.new(0)
      card.top_up(40)
      expect{ card.touch_in(:entry_station).touch_out(:exit_station) }.to change{ card.balance }.by(-Fare::MIN_FARE)
    end

    it 'forgets the entry station upon #touch_out' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      expect(card.touch_in(:entry_station).touch_out(:exit_station).entry_station).to eq nil
    end

    it 'saves the exit station' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      card.touch_out(:exit_station)
      expect(card.exit_station).to eq :exit_station
    end

  end

  describe "#Journies" do
    it 'Tests that the card has list of empty journies when created' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      expect(card.journies).to eq []
    end
    it 'tests that checks that touching in and out creates one journey' do
      # card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.journies).to eq [{entry_station: :entry_station, exit_station: :exit_station}]
    end
  end
end

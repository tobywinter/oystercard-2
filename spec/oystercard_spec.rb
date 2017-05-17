require 'oystercard'

describe Oystercard do

<<<<<<< HEAD
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
=======
  let(:fakestation) { double(:station) }

  it 'expects balance to be 0' do
    expect(subject.balance).to eq (0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'updates the balance when we top up' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
    it 'raises an error when top up exceeds £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "Balance exceeded #{maximum_balance}"
    end
  end


  describe '#deduct' do
    it 'deducts fare from the balance' do
      subject.top_up(20)
      subject.touch_out
      expect(subject.balance).to eq 20 - Fare::MIN_FARE
    end
  end

  it { is_expected.to respond_to(:in_journey?) }

  describe '#in_journey' do
    it 'returns false when new oystercard is created' do
      expect(subject.in_journey?).to eq false
    end
  end

  it { is_expected.to respond_to(:touch_in) }

  describe '#touch_in' do
    it 'can touch in'do
    card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
    card.touch_in(:fakestation)
    expect(card.in_journey?).to eq true
    end

    it 'raises an error when balance below minimum fare' do
      expect{ subject.touch_in (:fakestation)}.to raise_error "Balance below minimum fare"
    end

    it 'records the touch_in station' do
      card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      card.touch_in(:fakestation)
      expect(card.entry_station).to eq (:fakestation)
    end

  end

  it { is_expected.to respond_to(:touch_out) }
  describe '#touch_out' do
    it 'can touch out' do
    card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
    card.touch_in(:fakestation)
    card.touch_out
    expect(card.in_journey?).to eq false
    end

    it 'deduct minimun fare' do
      subject.top_up(40)
      expect{ subject.touch_in(:fakestation).touch_out }.to change{ subject.balance }.by(-Fare::MIN_FARE)
    end

    it 'forgets the entry station upon #touch_out' do
      card = Oystercard.new(Oystercard::MAXIMUM_BALANCE)
      expect(card.touch_in(:fakestation).touch_out.entry_station).to eq nil
    end
  end
end
>>>>>>> fd6e3210e65140fe9aac396bf2fe6d2206107363

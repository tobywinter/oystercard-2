require 'oystercard'

describe Oystercard do
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

  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe '#deduct' do
    it 'deducts fare from the balance' do
      subject.top_up(20)
      subject.deduct(10)
      expect(subject.balance).to eq 10
    end
  end

  it { is_expected.to respond_to(:in_journey) }

  describe '#in_journey' do
    it 'returns false when new oystercard is created' do
      expect(subject.in_journey).to eq false
    end
  end

  it { is_expected.to respond_to(:touch_in) }

  describe '#touch_in' do
    it 'can touch in'do
    subject.touch_in
    expect(subject.in_journey).to eq true
    end
  end

  it { is_expected.to respond_to(:touch_out) }
  describe '#touch_out' do
    it 'can touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey).to eq false
    end
  end

end

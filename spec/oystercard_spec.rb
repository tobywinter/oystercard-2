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
  end
end

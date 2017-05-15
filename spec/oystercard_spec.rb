require 'oystercard'

describe Oystercard do
  it 'expects balance to be 0' do
    expect(subject.balance).to eq (0)
  end
end

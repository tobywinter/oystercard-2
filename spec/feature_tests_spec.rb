require 'oystercard'

describe 'feature tests' do
  it 'charges a penalty fare when you touch in twice' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in('Bank')
    expect{ card.touch_in('Aldgate East') }.to change{ card.balance }.by(-Fare::PENALTY_CHARGE)
  end
end

require 'journey'



describe Journey do
  subject(:journey) {described_class.new}
  it 'it has penalty charge' do
    expect(journey.penalty_charge).to eq Journey::PENALTY_CHARGE
  end

  describe '#start' do
    it { is_expected.to respond_to(:start).with(0).argument }
  end
end

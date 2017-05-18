require 'journey'
require 'station'


describe Journey do
  subject(:journey) {described_class.new}
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  station1 = Station.new("Bank", 1)
  station2 = Station.new("Kingston", 6)


  it 'it has penalty charge' do
    expect(journey.penalty_charge).to eq Journey::PENALTY_CHARGE
  end

  describe '#start' do
    it 'saves entry station as instance variable' do
      expect{ journey.start(station1) }.to change{ journey.entry_station }.to eq('Bank')
    end
  end
end

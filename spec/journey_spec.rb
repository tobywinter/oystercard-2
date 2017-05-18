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

    it 'saves entry zone as instance variable' do
      expect{ journey.start(station1) }.to change{ journey.entry_zone }.to eq(1)
    end
  end

  describe '#finish' do
    it 'saves exit station as instance variable' do
      expect{ journey.finish(station2) }.to change{ journey.exit_station}.to eq('Kingston')
    end
  end
end

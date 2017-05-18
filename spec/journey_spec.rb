require 'journey'
require 'station'
require 'fare'

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

    it 'saves exit zone as an instance variable' do
      expect{ journey.finish(station2) }.to change{ journey.exit_zone}.to eq(6)
    end
  end

  describe '#calculate_distance' do
    it 'calculate distance between entry and exit zone' do
      journey.start(station1)
      journey.finish(station2)
      expect(journey.calculate_distance). to eq(6)
    end
  end

  describe '#calculate_fare' do
    it 'calculates fare based on journey distance' do
      journey.start(station1)
      journey.finish(station2)
      distance = journey.calculate_distance
      expect(journey.calculate_fare).to eq(distance * Fare::FARE_PER_ZONE)
    end
  end
end

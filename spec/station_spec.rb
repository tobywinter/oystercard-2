require 'station'

describe Station do
  subject(:station) {described_class.new(:zone, :station_name)}
  # zone, name
  describe '#zone' do
    it 'returns the station zone' do
      expect(station.zone).to eq :zone
    end

  end
  describe '#Station name' do
    it 'returns the station name' do
      expect(station.station_name).to eq :station_name
    end
  end
end

require 'station'

describe Station do
  before {@station = described_class.new(:station ,:zone)}
  it "returns the station name" do
    expect(@station.station_name).to eq :station
  end
  it "returns the zone" do
    expect(@station.zone).to eq :zone
  end

end

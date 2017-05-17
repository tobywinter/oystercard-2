require 'journey'

describe Journey do

  subject(:journey) { described_class.new(:mornington_cresent, :shadwell) }

    describe '#initialize' do

      it 'Initilizes with the journy object populated by the passed arguements' do
        expect(journey.log).to eq(:entry_station => :mornington_cresent, :exit_station => :shadwell)
      end
    end
    describe '#calculate_fare' do
      it "charges the Minimum_fare by feault" do
      expect(journey.calculate_fare).to eq journey.class::Minimum_fare
      end
    end
  end

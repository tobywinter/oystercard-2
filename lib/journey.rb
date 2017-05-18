

class Journey
  attr_reader :penalty_charge, :entry_station
  PENALTY_CHARGE = 10

  def initialize
      @penalty_charge = PENALTY_CHARGE
  end

  def start(entry_station)
    @entry_station = entry_station.station_name
  end

end

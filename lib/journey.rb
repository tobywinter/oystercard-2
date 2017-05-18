

class Journey
  attr_reader :penalty_charge, :entry_station, :entry_zone, :exit_station
  PENALTY_CHARGE = 10

  def initialize
      @penalty_charge = PENALTY_CHARGE
  end

  def start(entry_station)
    @entry_station = entry_station.station_name
    @entry_zone = entry_station.zone
  end

  def finish(exit_station)
    @exit_station = exit_station.station_name
  end

end

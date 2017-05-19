

class Journey
  attr_reader :penalty_charge, :entry_station, :entry_zone, :exit_station, :exit_zone
  PENALTY_CHARGE = 10

  def initialize
    @entry_station
    @exit_station
  end

  def start(entry_station)
    @entry_station = entry_station.station_name
    @entry_zone = entry_station.zone
  end

  def finish(exit_station)
    @exit_station = exit_station.station_name
    @exit_zone = exit_station.zone
  end

  def calculate_distance
    if zone_comparison == -1
      (exit_zone - entry_zone) + 1
    else zone_comparison == 1
      (entry_zone - exit_zone) + 1
    end
  end

  def calculate_fare
    return @fare = PENALTY_CHARGE if ( entry_station == nil || exit_station == nil )
    @fare = calculate_distance * Fare::FARE_PER_ZONE
  end

  private
  def zone_comparison
    @entry_zone <=> @exit_zone
  end

end

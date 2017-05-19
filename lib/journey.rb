

class Journey
  attr_reader :penalty_charge, :entry_station, :entry_zone, :exit_station, :exit_zone

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
    (entry_zone - exit_zone).abs + 1
  end

  def calculate_fare
    return @fare = Fare::PENALTY_CHARGE if entry_station == nil || exit_station == nil
    @fare = calculate_distance * Fare::FARE_PER_ZONE
  end

  def in_progress?
    !!@entry_station
  end
end

require_relative 'station'

class Journey

  Minimum_fare = 1
  Penalty_fare = 6

  attr_reader :log

  def initialize(entry_station, exit_station)
    @log = {entry_station: entry_station, exit_station: exit_station}
  end

  def calculate_fare
    if @log[:entry_station == nil]
      Penalty_fare
    else
      Minimum_fare
    end
  end
end

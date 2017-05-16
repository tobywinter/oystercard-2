require_relative 'station'
class Oystercard

  attr_reader :balance, :entry_station, :journey_log

  Maximum_balance = 90
  Minimum_fare = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_log = []
  end

  def top_up(amount)
    fail "Cannot top_up above #{Maximum_balance}" if amount + @balance > Maximum_balance
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < Minimum_fare
    @entry_station = station
  end

  def touch_out(fare = Minimum_fare, station)
    deduct_fare(fare)
    @journey_log << {entry_station: @entry_station, exit_station: station}
    @entry_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end

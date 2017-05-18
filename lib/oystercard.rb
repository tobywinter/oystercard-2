require_relative 'fare'
require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journies

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journies = []
  end

  def top_up(num)
    fail "Balance exceeded #{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
    self
  end


  def touch_in(station)
    fail "Balance below minimum fare" if @balance < Fare::MIN_FARE
    @entry_station = station
    self
  end

  def touch_out(station)
    deduct(Fare::MIN_FARE)
    @exit_station = station
    @journies << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    self
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(num)
    #balance can go below 0?
    @balance -= num
    self
  end

end

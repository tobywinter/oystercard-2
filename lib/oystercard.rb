require_relative 'fare'
require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journies, :journey

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @journies = []
    @journey = Journey.new
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
    @journies << @journey
    @entry_station = nil
    self
  end

  private

  def deduct(num)
    #balance can go below 0?
    @balance -= num
    self
  end

end

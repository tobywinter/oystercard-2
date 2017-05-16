require_relative 'fare'

class Oystercard

  attr_reader :balance
  attr_reader :in_journey
  attr_reader :entry_station

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(num)
    fail "Balance exceeded #{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
    self
  end

  def touch_in(station)
    fail "Balance below minimum fare" if @balance < Fare::MIN_FARE
    @in_journey = true
    @entry_station = station
    self
  end


  def touch_out
    @in_journey = false
    deduct(Fare::MIN_FARE)
    self
  end

  private

  def deduct(num)
    #balance can go below 0?
    @balance -= num
    self
  end

end

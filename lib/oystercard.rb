<<<<<<< HEAD
require_relative 'station'
class Oystercard

  attr_reader :balance, :entry_station, :journey_log

  Maximum_balance = 90
  Minimum_fare = 1
  Penalty_fare = 6

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
    @exit_station = station
    record_journey
    @entry_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def record_journey
    @journey_log << Journey.new(@entry_station, @exit_station).log
=======
require_relative 'fare'

class Oystercard

  attr_reader :balance
  attr_reader :entry_station

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
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

  def touch_out
    deduct(Fare::MIN_FARE)
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
>>>>>>> fd6e3210e65140fe9aac396bf2fe6d2206107363
  end

end

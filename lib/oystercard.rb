require_relative 'fare'
require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_log, :journey, :last_journey

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
    @journey_log = []
    @journey = Journey.new
  end

  def top_up(num)
    fail "Balance exceeded #{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
    self
  end


  def touch_in(station_name)
    fail "Balance below minimum fare" if @balance < Fare::MIN_FARE
    finish_journey if journey.in_progress?
    station = Station.new(station_name)
    @journey.start(station)
    self
  end

  def touch_out(station_name)
    station = Station.new(station_name)
    @journey.finish(station)
    finish_journey
  end

  private

  def save_journey_to_list
    @last_journey = @journey
    @journey_log << @journey
    @journey = Journey.new
  end

  def deduct(num)
    #balance can go below 0?
    @balance -= num
    self
  end

  def finish_journey
    deduct(@journey.calculate_fare)
    save_journey_to_list
  end

end

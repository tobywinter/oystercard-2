class Oystercard

  attr_reader :balance
  Maximum_balance = 90

  def initialize
    @balance = 0
    @in_journey = :ready_to_use
  end

  def top_up(amount)
    fail "Cannot top_up above #{Maximum_balance}" if amount + @balance > Maximum_balance
    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey == :in_journey
  end

  def touch_in
    @in_journey = :in_journey
  end

  def touch_out
    @in_journey = :ready_to_use
  end

end

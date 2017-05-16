class Oystercard


  attr_reader :balance
  Maximum_balance = 90
  Minimum_fare = 1
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Cannot top_up above #{Maximum_balance}" if amount + @balance > Maximum_balance
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient funds" if @balance < Minimum_fare
    @in_journey = true
  end

  def touch_out(fare)
    deduct_fare(fare)
    @in_journey = false
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end

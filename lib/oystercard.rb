class Oystercard

  attr_reader :balance
  Maximum_balance = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Cannot top_up above #{Maximum_balance}" if amount + @balance > Maximum_balance
    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

end

class MoneyCalculator
  attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands
  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    self.ones = ones
    self.fives = fives
    self.tens = tens
    self.twenties = twenties
    self.fifties = fifties
    self.hundreds = hundreds
    self.five_hundreds = five_hundreds
    self.thousands = thousands
  end

  def get_total
   return (self.ones*1)+(self.fives*5)+(self.tens*10)+(self.twenties*20)+(self.fifties*50)+(self.hundreds*100)+(self.five_hundreds*500)+(self.thousands*1000)
  end


  def change(cost,total)
    cust_change = total - cost
    thousands = cust_change/1000
    cust_change = cust_change - (thousands*1000)
    five_hundreds = cust_change/500
    cust_change = cust_change - (five_hundreds*500)
    hundreds = cust_change/100
    cust_change = cust_change - (hundreds*100)
    fifties = cust_change/50
    cust_change = cust_change - (fifties*50)
    twenties = cust_change/20
    cust_change = cust_change - (twenties*20)
    tens = cust_change/10
    cust_change = cust_change - (tens*10)
    fives = cust_change/5
    cust_change = cust_change - (fives*5)
    ones = cust_change
    hash_change = {:ones => ones, :fives => fives, :tens => tens, :twenties => twenties, :fifties => fifties, :hundreds => hundreds, :five_hundreds => five_hundreds, :thousands => thousands}
    return hash_change
  end
end

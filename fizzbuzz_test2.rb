
module FizzBuzzTest2
  require './FizzBuzzDSL'
  include FizzBuzzDSL # 最初にインクルードする

  count_upto 10

  def self.even_number? (num)  # 偶数を判定する
    num % 2 == 0
  end

  rule_for (:square) {|n| Math.sqrt(n).round ** 2 == n }  # 平方数
  rule_for (:even) {|n| even_number?(n) }  # 偶数

end
FizzBuzzTest2.fizzbuzz


#1-30までの数字から､完全数､素数､平方数を選び出す

module SpecialNumbers

  require 'prime'     # メソッドは外部ライブラリから読み込んでもよい
  require './FizzBuzzDSL'
  include FizzBuzzDSL # 最初にインクルードする


  set_counter from: 1, to: 30

  add_evaluator :perfect_num? do |num|                     # 完全数を判定するメソッド
    return false if num == 1
    num == sum_divisors(num, num-1)                        # 注:再帰的に計算しているため､桁を増やすとstack level too deepエラーになる
  end

  add_evaluator :sum_divisors do |num, i|                  # 計算用のメソッド定義
    raise ArgumentError if i<=0
    return 1 if i==1
    if (num % i).zero?
      i + sum_divisors(num,i-1)
    else
      sum_divisors(num,i-1)
    end
  end

  rule_for ('PERFECT') { |n| perfect_num?(n) }            # 完全数
  rule_for ('prime') {|n| n.prime? }                    # 素数
  rule_for ('square') {|n| Math.sqrt(n).round ** 2 == n } # 平方数

  fizzbuzz label: true, skip: true                        # 判定条件にかからなければ何も出力しない

end

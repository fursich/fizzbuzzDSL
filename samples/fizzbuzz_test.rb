
module FizzBuzzTest
  require './FizzBuzzDSL'
  include FizzBuzzDSL

  set_counter from: 10, to: 20

  rule_for (:fizzbuzz) { |n| n % 15 == 0 }  # 条件定義: ルールは上から優先して適用される
  rule_for (:fizz) { |n| n % 3 == 0 }       # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
  rule_for (:buzz) { |n| n % 5 == 0 }

  fizzbuzz                                   # 実行
end

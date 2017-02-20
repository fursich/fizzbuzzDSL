


module FizzBuzzCulc
  include FizzBuzzDSL # 最初にインクルードする

  setup do            # 数字を設定する
    @min = 2
    @max = 25
  end
  set_rules ('fizzbuzz') { |n| n % 15 == 0 } # ルールは上から優先して適用される
  set_rules ('fizz') { |n| n % 3 == 0 }      # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
  set_rules ('buzz') { |n| n % 5 == 0 }
  set_rules () { true }                      # 空引数の場合､数字をそのまま出力する
  fizzbuzz
end

module FizzBuzzCulc2
  include FizzBuzzDSL # 最初にインクルードする

                                              # @max,@minの指定がなければデフォルト(1-20)から探索

  set_rules ('fizzbuzz') { |n| n % 15 == 0 }  # ルールは上から優先して適用される
  set_rules ('fizz') { |n| n % 3 == 0 }       # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
  set_rules ('buzz') { |n| n % 5 == 0 }
  set_rules () { true }                       # 空引数の場合､数字をそのまま出力する
  fizzbuzz label: true
end

module SpecialNumbers

  require 'prime'     # メソッドは外部ライブラリから読み込んでもよい
  include FizzBuzzDSL # 最初にインクルードする


  setup do            # 探索範囲の指定が複数ある場合､最後の設定が有効
    @min = 1
    @max = 10
  end

  add_evaluator :perfect_num? do |num|  # 判定用メソッドを追加できる
    return false if num == 1
    num == sum_divisors(num, num-1)     # 注:再帰的に計算しているため､桁を増やすとstack level too deepエラーになる
  end
  add_evaluator :sum_divisors do |num, i| # 計算用の独自メソッド定義
    raise ArgumentError if i<=0
    return 1 if i==1
    if (num % i).zero?
      i + sum_divisors(num,i-1)
    else
      sum_divisors(num,i-1)
    end
  end

  set_rules ('perfect') { |n| self.perfect_num?(n) }      # 完全数
  set_rules ('prime') { |n| n.prime? }                     # 素数
  set_rules ('square') {|n| Math.sqrt(n).round ** 2 == n }  # 平方数
                      # 判定条件に引っかかった場合何も出力しない

  setup do            # 探索範囲の指定が重複する場合､最後の設定が有効
    @max = 100
  end

  fizzbuzz label: true # 実行

  reset_rules                                          # ルールをリセット
  set_rules ('perfect') { |n| self.perfect_num?(n) }   # 一度定義したメソッドは残る

  setup do            # 再び設定
    @min = 100
    @max = 9000
  end

  fizzbuzz label: true

end

class FizzBuzzCulc3
  include FizzBuzzDSL # 最初にインクルードする

  setup { @min=1000 }
                                              # @max,@minの指定がなければデフォルト(1-20)から探索

  set_rules ('fizzbuzz') { |n| n % 15 == 0 }  # ルールは上から優先して適用される
  set_rules ('fizz') { |n| n % 3 == 0 }       # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
  set_rules ('buzz') { |n| n % 5 == 0 }
  set_rules () { true }                       # 空引数の場合､数字をそのまま出力する
  fizzbuzz label: true
end

class FizzBuzzCulc3
  include FizzBuzzDSL # 最初にインクルードする

  load 'fizzbuzz_test1.rb'
end


self.setup { @min=-1 }
                                            # @max,@minの指定がなければデフォルト(1-20)から探索
self.set_rules ('fizzbuzz') { |n| n % 15 == 0 }  # ルールは上から優先して適用される
self.set_rules ('fizz') { |n| n % 3 == 0 }       # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
self.set_rules ('buzz') { |n| n % 5 == 0 }
self.set_rules () { true }                       # 空引数の場合､数字をそのまま出力する
self.fizzbuzz label: true

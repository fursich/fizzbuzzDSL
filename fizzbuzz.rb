
MIN_NUM = 1
MAX_NUM = 20

n = MIN_NUM
while n<=MAX_NUM do
  if n % 15 == 0
    s = 'fizzbuzz'
  elsif n % 3 == 0
    s = 'fizz'
  elsif n % 5 == 0
    s = 'buzz'
  else
    s = n.to_s
  end
  puts s
  n += 1
end

for n in (MIN_NUM..MAX_NUM) do
  s = ''
  if n % 3 == 0
    s = s + 'fizz'
  end
  if n % 5 == 0
    s = s + 'buzz'
  end
  if s == ''
    s = n.to_s
  end
  puts s
end

(MAX_NUM-MIN_NUM).times do |n|
  mod3 = (n % 3) == 0 ? 1 : 0
  mod5 = (n % 5) == 0 ? 1 : 0

  case 2 * mod5 + mod3
  when 0
    puts n
  when 1
    puts 'fizz'
  when 2
    puts 'buzz'
  when 3
    puts 'fizzbuzz'
  end
end


(MIN_NUM..MAX_NUM).each do |n|
  s = ''
  s += 'fizz' if n % 3 == 0
  s += 'buzz' if n % 5 == 0
  s = n.to_s if s==''
  puts s
end


MIN_NUM.upto MAX_NUM do |n|
  s = ''
  s << 'fizz' if (n % 3).zero?
  s << 'buzz' if (n % 5).zero?
  s = n.to_s if s.empty?
  puts s
end

def fizzbuzz(n)
  return :fizzbuzz if (n % 15).zero?
  return :fizz if (n % 3).zero?
  return :buzz if (n % 5).zero?
  n.to_s
end
MIN_NUM.upto MAX_NUM do |n|
  puts fizzbuzz(n)
end

def fizzbuzzR(n,max)
  return if n>max
  if (n % 15).zero?
    puts 'fizzbuzz'
  elsif (n % 3).zero?
    puts 'fizz'
  elsif (n % 5).zero?
    puts 'buzz'
  else
    puts n.to_s
  end
  fizzbuzzR(n+1, max)
end
fizzbuzzR(MIN_NUM, MAX_NUM)


a = (MIN_NUM..MAX_NUM).to_a.map do |n|
  m = n
  n = 'fizz' if (m % 3).zero?
  n = 'buzz' if (m % 5).zero?
  n = 'fizzbuzz' if (m % 15).zero?
  n.to_s
end
puts *a

(MIN_NUM..MAX_NUM).to_a.map { |n|
  m = n
  n = 'fizz' if (m % 3).zero?
  n = 'buzz' if (m % 5).zero?
  n = 'fizzbuzz' if (m % 15).zero?
  n.to_s
}.each { |s| puts s}

a = (MIN_NUM..MAX_NUM).to_a.map {|n|
  case [n % 3, n % 5].map(&:zero?)
  when [true, true]
    n='fizzbuzz'
  when [true, false]
    n='fizz'
  when [false, true]
    n='buzz'
  else
    n=n
  end
}.each{|s| puts s}

rule = { 15: 'fizzbuzz', 3: 'fizz', 5: 'buzz' }
def fizzbuzz(n)
  rule.each.do |m, comment|
    return comment if (n % m).zero?
  end
  return n.to_s
end
(MIN_NUM..MAX_NUM).to_a.each{ |s| puts fizzbuzz(s) }



MIN_NUM.upto MAX_NUM do |n|
  begin
    1/(n % 15)
  rescue
    puts 'fizzbuzz'
    next
  end
  begin
    1/(n % 3)
  rescue
    puts 'fizz'
    next
  end
  begin
    1/(n % 5)
  rescue
    puts 'buzz'
    next
  end
  puts n
end


class Fixnum
  def fizzbuzz
    n = self
    n = 'fizz' if (self % 3).zero?
    n = 'buzz' if (self % 5).zero?
    n = 'fizzbuzz' if (self % 15).zero?
    n.to_s
  end
end
(MIN_NUM..MAX_NUM).each {|s| puts s.fizzbuzz}


module FizzBuzzExtentions
  refine Fixnum do
    def fizzbuzz
      n = self
      n = 'fizz' if (self % 3).zero?
      n = 'buzz' if (self % 5).zero?
      n = 'fizzbuzz' if (self % 15).zero?
      n.to_s
    end
  end
end
module FizzBuzz
  using FizzBuzzExtentions
  (MIN_NUM..MAX_NUM).each {|s| puts s.fizzbuzz}
end




devidable = -> (n, m) {(m % n).zero?}
fizzbuzz = -> (s, b) {b ? s : nil}
MIN_NUM.upto MAX_NUM do |n|
  s = nil
  s ||= fizzbuzz.call(devidable.call(n,15), 'fizzbuzz')
  s ||= fizzbuzz.call(devidable.call(n,3), 'fizz')
  s ||= fizzbuzz.call(devidable.call(n,5), 'buzz')
  s ||= n.to_s
  puts s
end

devidable =-> (m, n) { (n % m).zero? }
db_curried = devidable.curry
db15 = db_curried.(15)
db3 = db_curried.(3)
db5 = db_curried.(5)
MIN_NUM.upto MAX_NUM do |i|
  case i
  when db15
    puts 'fizzbuzz'
  when db3
    puts 'fizz'
  when db5
    puts 'buzz'
  else
    puts i
  end
end

module PutsWrapper
  def puts n
    if n.is_a? Fixnum
      if (n % 15).zero?
        super 'fizzbuzz'
      elsif (n % 3).zero?
        super 'fizz'
      elsif (n % 5).zero?
        super 'buzz'
      else
        super n
      end
    else
      super n
    end
  end
end
Object.class_eval do
  prepend PutsWrapper
end
(MIN_NUM..MAX_NUM).each {|s| puts s}

module FizzBuzzDSL
  def self.included(klass)
    klass.extend FizzBuzzMethod
    klass.class_eval do
      @setups = []
      @rules = []
      @min = 1  #デフォルト最小値
      @max = 20 #デフォルト最大値
    end
  end

  module FizzBuzzMethod
    def setup(&block)
      @setups << block
    end
    def set_rules(script, &block)
      script = script.to_s unless script.is_a?(String)
      @rules << {script: script, condition: block}
    end

    def fizzbuzz
      @setups.each do |setup|
        setup.call
      end

      @min.upto @max do |num|
        @rules.each do |rule|
          if rule[:condition].call (num)
            if rule[:script].empty?
              puts num
            else
              puts rule[:script]
            end
            break
          end
        end
      end
    end

    def add_method(meth, &block)
      class << self
        self.send :define_method(meth, &block)
      end
    end

  end
end

module FizzBuzz

  include FizzBuzzDSL # 最初にインクルードする


  setup do            # 数字を設定する
    @min = 1
    @max = 20
  end

  set_rules ('fizzbuzz') { |n| n % 15 == 0 } # ルールは上から優先して適用される
  set_rules ('fizz') { |n| n % 3 == 0 }      # ()を外すと､後ろのブロックの解釈が変わるのでつけておく(またはdo..endでくくる)
  set_rules ('buzz') { |n| n % 5 == 0 }
  set_rules () { true } # 空引数の場合､数字をそのまま出力する
  fizzbuzz
end

module FizzBuzz2

  require 'prime'
  include FizzBuzzDSL # 最初にインクルードする


  setup do            # 数字を設定する
    @min = 1
    @max = 20
  end

  add_method :perfect_num? do |num|
    return false if num == 1
    num == add_divisors(num, num-1)
  end
  add_method :add_divisors do |num, i|
    raise ArgumentError if i<=0
    return 1 if i==1
    if (num % i).zero?
      i + pnum(num,i-1)
    else
      pnum(num,i-1)
    end
  end

  set_rules 'fizzybuzzy' do |n|                             # 完全数
    self.perfect_num?(n)
  end
  set_rules ('fizzy') {|n| Math.sqrt(n).round ** 2 == n }  # 平方数
  set_rules ('buzzy') { |n| n.prime? }                      # 素数
  set_rules ('others') { true }
  fizzbuzz
end












-----------------------------------

module FizzBuzz
  def self.included(klass)
    klass.extend FizzBuzzMethod
  end
  module FizzBuzzMethod
    def puts n
      if (n % 15).zero?
        super 'fizzbuzz'
      elsif (n % 3).zero?
        super 'fizz'
      elsif (n % 5).zero?
        super 'buzz'
      else
        super n
      end
    end
  end
end

class FizzBuzzTest
  include FizzBuzz
  def initialize(n)
    @n=n
  end
end

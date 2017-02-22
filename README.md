
#FizzBuzzDSL

A module that allows you to run fizzbuzz in simplest way.
You could also play with your own original FizzBuzz-esque rules - it accepts whatever rules you would like to add, thanks to the flexible structure that ruby provides.

# How to use

Just include FizzBuzzDSL module as below:


```ruby
module FizzBuzzTest

  require './FizzBuzzDSL'                      # assuming you put the DSL in your current folder
  include FizzBuzzDSL


  set_counter from: 10, to: 15                 # defines the ranges you would like to assess

  rule_for :fizzbuzz do |n|; n % 15 == 0; end  # upper rules are prioritised
  rule_for :fizz do |n|; n % 3 == 0; end
  rule_for :buzz do |n|; n % 5 == 0; end

  fizzbuzz                                     # Run

end
```

As simple as it can be!


## Play with your own original rules

You could also define original methods (doesn't have to be fizz-buzz funtion, but you can apply you own rules)


```ruby
module SpecialNumbers

  require 'prime'                       # external mothods are also available
  require './FizzBuzzDSL'
  include FizzBuzzDSL


  set_counter from: 5, to: 30

  add_evaluator :perfect_num? do |num|  # method that identifies perfect numbers
    return false if num == 1
    num == sum_divisors(num, num-1)     # (beware: the recursive method is only valid upto certain levels - or rutern errors 'stack level too deep')
  end

  add_evaluator :sum_divisors do |num, i| # sub-method that helps uppper method
    raise ArgumentError if i<=0
    return 1 if i==1
    if (num % i).zero?
      i + sum_divisors(num,i-1)
    else
      sum_divisors(num,i-1)
    end
  end

  rule_for (:PERFECT) { |n| self.perfect_num?(n) }        # perfect numbers (original method)
  rule_for (:prime) { |n| n.prime? }                      # prime numbers (provided by external library)
  rule_for (:square) {|n| Math.sqrt(n).round ** 2 == n }  # square numbers

  fizzbuzz label: true, skip: true                        # skipping the numbers that didn't fit with any of the above conditions

end
```

## methods

A "rule" is a message that accompanied with a block that gives boolean result when evaluated. (earlier rule is prioritized to the latter)

```ruby
rule_for ([message]) { |x| rule(x) }        # show the [message] when the given block is evaluated as true
rule_for [message] do |x|; rule(x); end     # you could also write the rule in this manner
reset_rules                                 # clear all the rules

To set ranges, you could use either of the following methods. (default range is from 1 to 20)

set_counter from: [min] to: [max]           # starting from [min] upto [max]
count_from [min]                            # start from [min]
count_upto [max]                            # continue till [max]

add_evaluator :original_method do |x|       # additional method is defined either of the following ways
  somerules(x)
end

def self.new_funtion (x)
  somerules(x)
end

fizzbuzz [label: boolean] [skip: boolean]   # execute DSL
                                            # (options) label - whether to show the number label
                                            #           skip  - true: skip the number when all the condition fails / false: show the number itself
```

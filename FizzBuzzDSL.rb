

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
    def reset_rules
      @rules = []
    end

    def fizzbuzz(label: true)
      @setups.each do |setup|
        setup.call
      end

      @min.upto @max do |num|
        prefix = label && "#{num}: "
        @rules.each do |rule|
          if rule[:condition].call (num)
            if rule[:script].empty?
              puts "#{prefix}#{num}"
            else
              puts "#{prefix}#{rule[:script]}"
            end
            break
          end
        end
      end
    end

    def add_evaluator(meth, *arg, &block)
      self.define_singleton_method meth, *arg, &block
    end

  end
end

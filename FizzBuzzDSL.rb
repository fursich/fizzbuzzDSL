

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
    def set_counter (from: nil, to: nil)
      @min = from || @min
      @max = to || @max
      puts "warning: counter set from #{from} to #{to} (wrong order)" if @min > @max
    end
    def count_from(min)
      @min = min
    end
    def count_upto(max)
      @max = max
    end

    def rule_for(script='', &block)
      return false unless block_given?
      @rules << {script: script, condition: block}
    end
    def reset_rules
      @rules = []
    end

    def add_evaluator(meth, *arg, &block)
      meth.to_sym if meth.is_a?(String)
      return false unless meth.is_a?(Symbol)
      return false unless block_given?
      self.define_singleton_method meth, *arg, &block
    end

    def fizzbuzz(label: true, skip: false)

      unless skip    # 条件が全て偽のときにも､数字をスキップしない場合
        noskip = {script: '', condition: Proc.new{true} }
        @rules << noskip
      end

      @min.upto @max do |num|
        prefix = label && "#{num}: "      # 数字ラベルをつける場合
        @rules.each do |rule|
          if rule[:condition].call (num)  # 条件を判定
            if rule[:script].empty?       # スクリプトが指定されていない場合は数字を出力
              puts "#{prefix}#{num}"
            else
              puts "#{prefix}#{rule[:script]}"
            end
            break                         # 一つでも条件に該当したら次の数字へ
          end
        end
      end
    end

  end
end

require 'pry'
require 'benchmark'
class Monkey
    attr_accessor :name, :inventory, :op, :throw_cond
    def initialize name, zoo
        @inventory = []
        @name = name
        @op = ->(w) { w }
        @throw_cond = ->(w) { @name }
        @zoo = zoo
    end
    def inspect!
        # @inventory.map! { |w| (@op[w]/3).floor }
        @inventory.map! { |w| (@op[w]).floor % @zoo.div_test_lcm }
        @zoo.inspect_counts[@name] += @inventory.size
        self
    end
    def throw!
        @inventory.each { |w| 
            recipient = @zoo.get @throw_cond[w]
            recipient.inventory << w
        }
        @inventory = []
        self
    end
end

class Zoo
    attr_accessor :div_test_lcm
    attr_reader :monkies, :inspect_counts
    def initialize 
        @monkies = {}
        @inspect_counts = {}
        @div_test_lcm = 1
    end
    def new_monkey name, *args, **kwargs
        @inspect_counts[name] = 0
        @monkies[name] = Monkey.new name, self, *args, **kwargs
    end
    def get name
        @monkies[name]
    end
    def step!
        @monkies.keys.sort.each do |k|
            @monkies[k].inspect!
            @monkies[k].throw!
        end
        self
    end
end

input = open('11.txt').read
zoo = Zoo.new
re = /
    Monkey\ (\d):\n
        \s+Starting\ items:\ ((?:\d\d,?\ ?)+)\n
        \s+Operation:\ new\ =\ (.+)\n
        \s+Test:\ divisible\ by\ (\d+)\n
            \s+If\ true:\ throw\ to\ monkey\ (\d)\n
            \s+If\ false:\ throw\ to\ monkey\ (\d)\n
/x
input.scan(re) do 
    name, items, op, div_test, true_name, false_name = $~.captures
    m = zoo.new_monkey name.to_i
    puts "mo #{name}"
    m.inventory = items.scan(/\d\d/).map(&:to_i)
    puts "inv #{items}"
    m.op = ->(old) { eval op }
    puts "op old -> #{op}"
    m.throw_cond = ->(w) { w % div_test.to_i == 0 ? true_name.to_i : false_name.to_i }
    zoo.div_test_lcm *= div_test.to_i
    puts "throw cond ->(w) { w % #{div_test} == 0 ? #{true_name} : #{false_name} }"
end
# pp zoo
# 20.times { zoo.step! }
# pp zoo
# puts "part 1: #{zoo.inspect_counts.values.sort[-2..-1].inject(:*)}"
pp zoo
# Benchmark.bm do |x|
#     times = []
#     100.times do 
#         times << x.report { zoo.step! }
#     end
#     [times.inject(:+), times.inject(:+)/times.size]
# end
10000.times { zoo.step! }
puts "part 2: #{zoo.inspect_counts.values.sort[-2..-1].inject(:*)}"
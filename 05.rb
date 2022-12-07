require 'byebug'

stacksIn, instructionsIn = open("05.txt").read.split("\n\n")
puts stacksIn
puts instructionsIn

STACKCOUNT = 9
STACKS = []
STACKCOUNT.times do STACKS << [] end
stacksIn.lines.reverse.drop(1).each do |stackLine|
    STACKCOUNT.times do |offset|
        STACKS[offset] << stackLine[(offset*4)+1]
        STACKS[offset].reject!{|s| s.strip.empty? }
    end
end

def mv1(stacks, from, to, count)
    puts "FROM #{from} TO #{to} x#{count}"
    count.times do |c|
        temp = stacks[from-1].pop
        unless temp.nil?
            stacks[to-1] << temp
        else
            byebug
        end
    end
end

def mv2(stacks, from, to, count)
    puts "FROM #{from} TO #{to} x#{count}"
    temp = []
    count.times do |c|
        temp << stacks[from-1].pop
    end
    stacks[to-1] += temp.reverse
end


instructionsIn.lines.each do |instruction|
    p STACKS
    instruction =~ /move (\d+) from (\d) to (\d)/
    mv2(STACKS, $2.to_i, $3.to_i, $1.to_i)
end

p STACKS
p STACKS.map(&:last).join
require 'set'

def toSet(box)
    box.chars.to_set
end

def toPrio(item)
    lc = (?a..?z).to_a.zip((1..26).to_a).to_h
    uc = (?A..?Z).to_a.zip((27..52).to_a).to_h
    lc.merge(uc)[item]
end

input = open("03.txt").read

finalPrio = 0

input.split("\n").each do |line|
    box1 = line[0,line.length/2].chars.to_set
    box2 = line[line.length/2,line.length].chars.to_set
    common = box1.intersection box2
    sharedPrios = common.map do |item|
        toPrio item
    end
    finalPrio += sharedPrios.sum
end
puts finalPrio

finalPrio1=0
input.split("\n").each_slice 3 do |lines|
    sacks = lines.map {|l| l.chars.to_set }
    item = sacks[0].intersection(sacks[1]).to_set.intersection(sacks[2])
    finalPrio1 += toPrio(item.to_a.pop)
end
puts finalPrio1
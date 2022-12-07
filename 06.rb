require 'set'

data = open("06.txt").read.chars
data.each_cons(4).with_index do |ds, idx|
    if ds.to_set.size == 4
        puts idx+4 
        break
    end
end
data.each_cons(14).with_index do |ds, idx|
    if ds.to_set.size == 14
        puts idx+14
        break
    end
end
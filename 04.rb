require 'pry'

input = open("04.txt").read

p input.split(?\n).to_a.map { |line|
    line =~ /(\d+)-(\d+),(\d+)-(\d+)/
    range1 = ($1.to_i..$2.to_i) 
    range2 = ($3.to_i..$4.to_i)
    if range1.cover?(range2) || range2.cover?(range1)
        1 
    else 
        0 
    end
}.sum

p input.split(?\n).to_a.map { |line|
    line =~ /(\d+)-(\d+),(\d+)-(\d+)/
    range1 = ($1.to_i..$2.to_i).to_a
    range2 = ($3.to_i..$4.to_i).to_a
    if (range1 & range2).empty?
        0
    else 
        1 
    end
}.sum
input = open("01.txt").read
calCounts = []
curCalCount = 0
input.split("\n").each do |line|
    if line.strip == "" 
        puts "done"
        puts curCalCount
        calCounts << curCalCount
        curCalCount = 0
    else
        curCalCount = curCalCount + line.to_i
    end
end
puts calCounts.sort
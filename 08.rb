require 'byebug'

input = open('08.txt').read.lines.map(&:strip).map(&:chars)

# visibles = input.map.with_index do |line, y|
#     line.map.with_index do |height, x|
#         left = input[y][0,x]
#         right = input[y][x+1,input[y].size]
#         top = input.transpose[x][0,y]
#         bottom = input.transpose[x][y+1,input.transpose[x].size]
#         left.all? { |t| height > t } || right.all? { |t| height > t } || top.all? { |t| height > t } || bottom.all? { |t| height > t } 
#     end
# end
# p visibles.map{|row| row.map{|b| if b then 1 else 0 end }}.map(&:sum).sum
scenic_scores = input.map.with_index do |line, y|
    line.map.with_index do |height, x|
        left = input[y][0,x].reverse
        left_dist = left.index { |t| t >= height } || left.size - 1
        right = input[y][x+1,input[y].size]
        right_dist = right.index { |t| t >= height } || right.size - 1
        top = input.transpose[x][0,y].reverse
        top_dist = top.index { |t| t >= height } || top.size - 1
        bottom = input.transpose[x][y+1,input.transpose[x].size]
        bottom_dist = bottom.index { |t| t >= height } || bottom.size - 1


        (left_dist+1)*(right_dist+1)*(top_dist+1)*(bottom_dist+1)
    end
end
scenic_scores.each{|s| print s}
p scenic_scores.map(&:max).max
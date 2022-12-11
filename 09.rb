require 'pry'
require 'set'

def sgn x
    if x < 0
        -1
    elsif x > 0
        1
    else 
        0
    end
end

$t = [[0,0]]
$h = [[0,0]]
def move direction
    case direction
    when :U
        $h << [$h.last[0] + 1, $h.last[1]]
    when :D
        $h << [$h.last[0] - 1, $h.last[1]]
    when :L
        $h << [$h.last[0], $h.last[1] - 1]
    when :R
        $h << [$h.last[0], $h.last[1] + 1]
    end
    tail_offset = $h.last.zip($t.last).map{|h,t| h-t}
    if (tail_offset[0].abs >= 1 and tail_offset[1].abs > 1) or (tail_offset[0].abs > 1 and tail_offset[1].abs >= 1)
        $t << [$t.last[0] + sgn(tail_offset[0]), $t.last[1] + sgn(tail_offset[1])]
    elsif tail_offset[0].abs > 1 
        $t << [$t.last[0] + sgn(tail_offset[0]), $t.last[1]]
    elsif tail_offset[1].abs > 1 
        $t << [$t.last[0], $t.last[1] + sgn(tail_offset[1])]
    else 
        $t << $t.last
    end
end

input = open('09.txt').read.lines
input.each do |line|
    line =~ /(\w) (\d+)/ 
    $2.to_i.times { move $1.to_sym }
end
# puts "head"
# p $h
# puts "tail"
# p $t
pp $t.to_set.size


# =======================
$ts = {}
9.times do |n|
    $ts[n] = [[0,0]]
end
$h = [[0,0]]
def move direction
    case direction
    when :U
        $h << [$h.last[0] + 1, $h.last[1]]
    when :D
        $h << [$h.last[0] - 1, $h.last[1]]
    when :L
        $h << [$h.last[0], $h.last[1] - 1]
    when :R
        $h << [$h.last[0], $h.last[1] + 1]
    end
    $ts.keys.each do |tail_idx|
        t = $ts[tail_idx]
        cur_head = if tail_idx == 0 then $h.last else $ts[tail_idx-1].last end
        cur_tail = t.last
        offset = cur_head.zip(cur_tail).map{|h,t| h-t}
        if (offset[0].abs >= 1 and offset[1].abs > 1) or (offset[0].abs > 1 and offset[1].abs >= 1)
            t << [cur_tail[0] + sgn(offset[0]), cur_tail[1] + sgn(offset[1])]
        elsif offset[0].abs > 1 
            t << [cur_tail[0] + sgn(offset[0]), cur_tail[1]]
        elsif offset[1].abs > 1 
            t << [cur_tail[0], cur_tail[1] + sgn(offset[1])]
        else 
            t << cur_tail
        end
    end
end

def show
    (-10..10).each do |y|
        (-10..10).each do |x|
            print $ts.map{|name, tail|
                if [x,y] == tail.last
                    name.to_s
                else
                    '.'
                end
            }.max
        end
        puts
    end
end

input = open('09.txt').read.lines
input.each do |line|
    line =~ /(\w) (\d+)/ 
    $2.to_i.times { move $1.to_sym }
    # show
end
pp $ts[$ts.keys.max].to_set.size
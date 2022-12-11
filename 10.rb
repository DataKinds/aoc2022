require 'pry'
input = open('10.txt').read.lines
$cycle = 1
$x = 1

def p_cycle
    puts "cycle #{$cycle} x #{$x} str #{$cycle*$x}"
end

$strength_history = {}
$x_history = []
def record_cycle
    p_cycle
    $x_history << $x
    $strength_history[$cycle] = $cycle*$x
end

def draw_crt
    out = ""
    $x_history.each_slice(40) do |xs|
        xs.each.with_index do |x, crt_position|
            crt_x = x - 1
            if crt_position - crt_x < 3 and crt_position >= crt_x
                out += '#'
            else
                out += '.'
            end
        end
        out += ?\n
    end
    out
end


record_cycle
input.each do |line|
    case line
    when /noop/
        $cycle += 1
    when /addx (-?\d+)/
        $cycle += 1
        record_cycle
        $x += $1.to_i
        $cycle += 1
    end
    record_cycle
end
puts $strength_history.values_at(20, 60, 100, 140, 180, 220).sum
p $x_history
puts draw_crt
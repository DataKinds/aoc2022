X_SIZE = 1000
Y_SIZE = 200

$world = []
Y_SIZE.times do |y|
    $world[y] = []
    X_SIZE.times do |x|
        $world[y][x] = :air
    end
end

def bounds
    x_max, x_min, y_max, y_min = -Float::INFINITY, Float::INFINITY, -Float::INFINITY, Float::INFINITY
    $world.each.with_index { |row, y|
        row.each.with_index { |tile, x|
            if tile != :air
                x_max = [x_max, x].max
                x_min = [x_min, x].min
                y_max = [y_max, y].max
                y_min = [y_min, y].min
            end 
        }
    }
    [x_min, x_max, y_min, y_max]
end

def pworld
    x_min, x_max, y_min, y_max = bounds
    Y_SIZE.times do |y|
        row = $world[y]
        puts (x_min..x_max).each.map {|x|
            case row[x]
            when :air
                '.'
            when :sand
                'o'
            when :rock
                '#'
            else
                '?'
            end
        }.join
    end
end

def spawn 
    if $world[0][500] == :air
        $world[0][500] = :sand
        true
    else
        false
    end
end

def tick
    # we can edit in place because the spawn mechanism guarantees only 1 tile moving at a time
    # new_world = Y_SIZE.times.map {|y| $world[y].dup }
    did_move = false
    did_void = false
    out = :none
    $world.each.with_index { |row, y|
        row.each.with_index { |tile, x|
            case tile
            when :sand
                if y + 1 >= Y_SIZE
                    did_void = true
                    # new_world[y][x] = :air
                    $world[y][x] = :air
                else
                    if $world[y+1][x] == :air
                        # new_world[y][x] = :air
                        # new_world[y+1][x] = :sand
                        $world[y][x] = :air
                        $world[y+1][x] = :sand
                        did_move = true
                    elsif $world[y+1][x-1] == :air
                        # new_world[y][x] = :air
                        # new_world[y+1][x-1] = :sand
                        $world[y][x] = :air
                        $world[y+1][x-1] = :sand
                        did_move = true
                    elsif $world[y+1][x+1] == :air
                        # new_world[y][x] = :air
                        # new_world[y+1][x+1] = :sand
                        $world[y][x] = :air
                        $world[y+1][x+1] = :sand
                        did_move = true
                    end
                end 
            end
        }
    }
    if did_void
        :void
    elsif did_move
        :moved
    else
        :none
    end
end

# generate world
input = open('14.txt').read.lines
input.each do |line|
    line.scan(/(?=\b(\d+),(\d+) -> (\d+),(\d+))/).each do |x1, y1, x2, y2|
        puts "#{x1},#{y1} -> #{x2},#{y2}"
        x1, x2 = x2, x1 if x1 > x2 
        y1, y2 = y2, y1 if y1 > y2
        (y1.to_i..y2.to_i).each do |y|
            puts "y: #{y}"
            (x1.to_i..x2.to_i).each do |x|
                puts "x: #{x}"
                $world[y][x] = :rock
            end
        end
    end
end
# add part 2 floor
x_min, x_max, y_min, y_max = bounds
$world[y_max + 2] = [:rock] * X_SIZE

def main
    spawn
    pworld
    100000.times do |itercount|
        if itercount % 100 == 0
            puts "-"*10
            pworld
        end
        STDERR.puts "(#{itercount})" if itercount % 100 == 0
        case tick
        when :void
            STDERR.puts "(#{itercount}): got a void!"
            pworld
            return [$world.map {|row| row.map {|tile| tile == :sand ? 1 : 0}.sum}.sum, itercount]
        when :none
            STDERR.puts "(#{itercount}): spawning"
            if !spawn
                STDERR.puts "(#{itercount}): blocked! couldn't spawn"
                return [$world.map {|row| row.map {|tile| tile == :sand ? 1 : 0}.sum}.sum, itercount]
            end
        end
    end
    STDERR.puts "broke out of loop!"
end

print main
# pworld
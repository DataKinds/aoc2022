INPUT = open('21_2.txt').read.lines

MONKIES = {}

def step_monk name
    if MONKIES[name].is_a? Array
        in1, op, in2 = MONKIES[name]
        MONKIES[name] = case op
        when ?-
            step_monk(in1) - step_monk(in2)
        when ?+
            step_monk(in1) + step_monk(in2)
        when ?*
            step_monk(in1) * step_monk(in2)
        when ?/
            step_monk(in1) / step_monk(in2)
        else
            puts "BIG OL ERROR"
        end
    else
        MONKIES[name]
    end
end

def step_op
    MONKIES.keys.each do |name|
        if MONKIES[name].is_a? Array
            step_monk name
        end
    end
end

def get_diff humn_input
    INPUT.each do |mon|
        case mon
        when /(\w{4}): X/
            MONKIES[$1] = humn_input
        when /(\w{4}): (\d+)/
            MONKIES[$1] = $2.to_i
        when /(\w{4}): (\w{4}) (.) (\w{4})/
            MONKIES[$1] = [$2, $3, $4]
        end
    end
    100.times do step_op end
    MONKIES['root']
end

test_input = 3000000000000 # close to real answer, from trial & error
jump = 10000000000
# weird manual convergence
loop do
    loop do  
        error = get_diff(test_input)
        puts "tried humn: #{test_input}, got diff #{error}"
        if error.abs < jump * 100
            puts "scaling down!"
            break
        end
        if error < 0
            test_input -= jump
        else
            test_input += jump
        end
    end
    jump /= 10
end
p MONKIES['root']
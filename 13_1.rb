input = open('13_1.txt').read.lines


OLD_NUM_CMP = Numeric.instance_method(:<=>)
class Numeric
    def <=>(other)
        if other.is_a? Array
            [self] <=> other
        else 
            OLD_NUM_CMP.bind_call self, other
        end
    end
end

OLD_ARY_CMP = Array.instance_method(:<=>)
class Array
    def <=>(other)
        if other.is_a? Numeric
            OLD_ARY_CMP.bind_call self, [other]
        else 
            OLD_ARY_CMP.bind_call self, other
        end
    end
end

idxs = input.each_slice(3).with_index.map{|ls, idx|
    left = eval ls[0]
    right = eval ls[1]
    puts "(#{idx + 1}) comparing #{left} with #{right}, got #{left <=> right}"
    if (left <=> right) == -1 
        idx + 1
    else
        0
    end
}
p idxs
puts idxs.sum
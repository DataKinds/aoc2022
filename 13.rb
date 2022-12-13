input = open('13.txt').read.lines

def cmp a, b
    # puts "cmp #{a.inspect} #{b.inspect}"
    if a.is_a? Array and b.is_a? Array
        (a+[nil]*1000).zip(b).each do |sub_a, sub_b|
            return 0 if sub_a.nil? and sub_b.nil?
            return -1 if sub_a.nil?
            return 1 if sub_b.nil?
            go = cmp(sub_a,sub_b)
            return go unless go.zero?
        end
    elsif a.is_a? Numeric and b.is_a? Numeric
        a <=> b
    else
        a = a.is_a?(Numeric) ? [a] : a
        b = b.is_a?(Numeric) ? [b] : b
        cmp(a, b)
    end 
end

idxs = input.each_slice(3).with_index.map{|ls, idx|
    left = eval ls[0]
    right = eval ls[1]
    puts "(#{idx + 1}) comparing #{left} with #{right}, got #{cmp(left, right)}"
    if cmp(left, right) == -1 
        idx + 1
    else
        0
    end
}
p idxs
puts idxs.sum

input2 = open('13_2.txt').read.lines.reject{|line| line.strip == ""}
input2.sort{|a,b| cmp(eval(a), eval(b)) }.each.with_index{|line, idx|
    puts "(#{idx+1}) #{line}"
}

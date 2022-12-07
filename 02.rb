def outcome(m1, m2)
    {
        A: {X: :draw, Y: :win, Z: :loss},
        B: {Y: :draw, Z: :win, X: :loss},
        C: {Z: :draw, X: :win, Y: :loss},
    }[m1.to_sym][m2.to_sym]
end

def moveScore(m)
    {X: 1, Y: 2, Z: 3}[m.to_sym]
end

input = open("02.txt").read
out = input.split(?\n).map do |line|
    move1, move2 = line.split ?\ 
    moveScore(move2) + case outcome move1, move2
    when :draw
        3
    when :loss
        0
    when :win
        6
    end
end
puts out.sum

input = open("02.txt").read
def neededMove(enemyMove, victory)
    {   # x is lose, y is draw, z is win
        A: {X: :Z, Y: :X, Z: :Y},
        B: {X: :X, Y: :Y, Z: :Z},
        C: {X: :Y, Y: :Z, Z: :X},
    }[enemyMove.to_sym][victory.to_sym]
end
out = input.split(?\n).map do |line|
    enemyMove, victory = line.split ?\ 
    moveScore(neededMove enemyMove, victory) + case victory.to_sym
    when :X
        0
    when :Y
        3
    when :Z
        6
    end
end
puts out.sum
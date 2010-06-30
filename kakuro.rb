class Array
  def sum
    inject(0) { |s, a| s + a}
  end
end

sum = ARGV.shift.to_i
num = ARGV.shift.to_i
must = ARGV.map { |a| a.to_i }

DIGITS = [1, 2, 3, 4, 5, 6, 7, 8, 9]
PRESENT = Hash[DIGITS.map { |d| [d, 0]  }]

good = DIGITS.combination(num).to_a.select { |a| sum == a.sum }
unless must.empty?
  good = good.select { |a| must.all? { |m| a.include? m }  }
end

puts "Combinations:"
good.each do |g|
  p g
  g.each do |d|
    PRESENT[d] += 1
  end
end

puts "In all: "
p PRESENT.select { |k, v| v == good.size }.map { |a| a.first }.sort

puts "Never: "
p PRESENT.select { |k, v| v == 0 }.map { |a| a.first }.sort
sum_part1 = 0
regex = /mul\((\d{1,3}),(\d{1,3})\)/

File.foreach('day_03_input.txt') do |line|
  line.scan(regex) do |x, y|
    sum_part1 += (x.to_i * y.to_i)
  end
end

puts "Part 1: #{sum_part1}"

sum_part2 = 0
regex = /(don't\(\)|do\(\)|mul\((\d{1,3}),(\d{1,3})\))/
matches = []
enabled= true

File.foreach('day_03_input.txt') do |line|
  matches << line.scan(regex)
end

matches.flatten(1).each do |match|
  case
  when match[0] == "do()" then enabled = true
  when match[0] == "don't()" then enabled = false
  when enabled then sum_part2 += (match[1].to_i * match[2].to_i)
  end
end

puts "Part 2: #{sum_part2}"
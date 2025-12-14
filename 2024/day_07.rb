
def combinable?(numbers, target, current_value, index, use_concat)
  return false if current_value > target
  return current_value == target if index == numbers.size

  return true if combinable?(numbers, target, current_value + numbers[index], index + 1, use_concat)
  return true if combinable?(numbers, target, current_value * numbers[index], index + 1, use_concat)
  if use_concat
    return true if combinable?(numbers, target, "#{current_value}#{numbers[index]}".to_i, index + 1, use_concat)
  end
  false
end

def process_line(line, use_concat)
  test_value, numbers = line.split(':').map(&:strip)
  test_value = test_value.to_i
  numbers = numbers.split.map(&:to_i)

  combinable?(numbers, test_value, numbers[0], 1, use_concat) ? test_value : 0
end

possible_summed_part1 = 0
possible_summed_part2 = 0

File.foreach("day_07_input.txt") do |line|
  possible_summed_part1 += process_line(line, false)
  possible_summed_part2 += process_line(line, true)
end

puts "Part 1: #{possible_summed_part1}"
puts "Part 2: #{possible_summed_part2}"
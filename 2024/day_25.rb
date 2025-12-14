keys = []
locks = []

def parse_section(lines)
  (0..4).map do |index|
    lines.map { |line| line[index] == '#' ? 1 : 0 }.sum
  end
end

File.readlines('day_25_input.txt').map(&:chomp).each_slice(8) do |lines|
  if lines[0] == '#####'
    keys << parse_section(lines[1..-2])
  else
    locks << parse_section(lines[0..-3])
  end
end

matches = 0

keys.count do |key|
  locks.each do |lock|
    matches += 1 unless key.zip(lock).any? { |k, l| k + l > 5 }
  end
end

# puts "Keys: #{keys.inspect}"
# puts "Locks: #{locks.inspect}"
puts "Part 1: #{matches}"
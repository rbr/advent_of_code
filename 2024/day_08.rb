@grid = File.foreach("day_08_input.txt").map { |line| line.chomp.chars }

character_coordinates = Hash.new { |hash, key| hash[key] = [] }

@grid.each_with_index do |row, y|
  row.each_with_index do |char, x|
    next if char == "."
    character_coordinates[char] << [x, y]
  end
end

def in_bounds?(coord1, coord2)
  coord1.between?(0, @grid[0].size - 1) && coord2.between?(0, @grid.size - 1)
end

antinodes_part1 = Set.new
antinodes_part2 = Set.new

character_coordinates.each do |char, coordinates|
  coordinates.permutation(2).each do |(coord1, coord2)|
    antinodes_part2.add([coord1[0], coord1[1]])
    diff = [coord1[0] - coord2[0], coord1[1] - coord2[1]]
    antinode = [coord1[0] + diff[0], coord1[1] + diff[1]]
    repeat = 1

    loop do
      antinode = [coord1[0]  + (diff[0] * repeat), coord1[1] + (diff[1] * repeat)]
      break unless in_bounds?(antinode[0], antinode[1])

      antinodes_part1.add(antinode) if repeat == 1
      antinodes_part2.add(antinode)
      repeat += 1
    end
  end
end

puts "Part 1: #{antinodes_part1.size}"
puts "Part 2: #{antinodes_part2.size}"
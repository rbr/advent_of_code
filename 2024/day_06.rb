@map = []
@start_position = nil

File.foreach("day_06_input.txt").with_index do |line, row_index|
  row = line.chomp.chars
  @map << row

  if @start_position.nil?
    col_index = row.index("^")
    @start_position = [row_index, col_index] if col_index
  end
end

def next_position(position, direction)
  row, col = position
  
  case direction
  when :up then [row - 1, col]
  when :right then [row, col + 1]
  when :down then [row + 1, col]
  when :left then [row, col - 1]
  end
end

def patrol(map)
  position = @start_position
  directions = [:up, :right, :down, :left].cycle
  direction = directions.next
  visited = Set.new([position])
  bumped = Set.new

  loop do
    move_to = next_position(position, direction)
    return [:exit, visited] unless move_to[0].between?(0, map.size - 1) && move_to[1].between?(0, map[0].size - 1)

    while map[move_to[0]][move_to[1]] == "#"
      return [:stuck, visited] if bumped.include?([move_to, direction])
      bumped.add([move_to, direction])

      direction = directions.next
      move_to = next_position(position, direction)
    end

    position = move_to
    visited.add(position)
  end
end

part_1_result = patrol(@map)
puts "Part 1: #{part_1_result[1].size}"

stuck_count = 0
path = part_1_result[1]
path.delete(path.first)

##todo: parallelize: https://github.com/ariejan/advent-of-code-2024/blob/main/lib/solutions/day_06.rb#L56
path.each do |position|
  new_map = @map.map(&:dup)
  new_map[position[0]][position[1]] = "#"

  result = patrol(new_map)
  stuck_count += 1 if result[0] == :stuck
end

puts "Part 2: #{stuck_count}"
@grid = File.readlines('day_10_input.txt').collect { |line| line.chomp.chars.collect(&:to_i) }
@size = [@grid.size - 1, @grid[0].size - 1]
@directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
@paths = []

def find_next(current, path, expected, step = 0, log = false)
  row, cell = current

  @directions.each do |di, dj|
    check = [row + di, cell + dj]
    next unless check[0].between?(0, @size[0]) && check[1].between?(0, @size[1])
    next unless @grid[check[0]][check[1]] == expected
    next if path.any? { |_, c| c == check }

    path_dup = path.dup
    path_dup << [expected,[check[0], check[1]]]

    if expected == 9
      @paths << path_dup
      next
    end
    find_next([row + di, cell + dj], path_dup, expected + 1, step + 1)
  end
end

@grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next unless cell == 0
    find_next([i, j], [[0, [i, j]]], 1)
  end
end

uniq_start_end = @paths.collect { |path| [path.first[1], path.last[1]] }.uniq
puts "Part 1: #{uniq_start_end.count}"
puts "Part 2: #{@paths.count}"
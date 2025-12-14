def flood_fill(x, y, letter)
  return [[], 0] if x < 0 || x >= @grid.size || y < 0 || y >= @grid[0].size
  return [[], 0] if @visited[x][y] || @grid[x][y] != letter

  @visited[x][y] = true
  coordinates = [[x, y]]
  perimeter = 0

  @directions.each do |dx, dy|
    nx, ny = x + dx, y + dy
    if nx < 0 || nx >= @grid.size || ny < 0 || ny >= @grid[0].size || @grid[nx][ny] != letter
      perimeter += 1
    else
      extra_coor, extra_peri = flood_fill(nx, ny, letter)
      coordinates += extra_coor
      perimeter += extra_peri
    end
  end

  [coordinates, perimeter]
end

def count_corners(area)
  corners = 0

  area.each do |i, j|
    up, down, left, right = [i - 1, j], [i + 1, j], [i, j - 1], [i, j + 1]
    up_left, up_right, down_left, down_right = [i - 1, j - 1], [i - 1, j + 1], [i + 1, j - 1], [i + 1, j + 1]

    corners += 1 if !area.include?(up) && !area.include?(left)
    corners += 1 if !area.include?(up) && !area.include?(right)
    corners += 1 if !area.include?(down) && !area.include?(left)
    corners += 1 if !area.include?(down) && !area.include?(right)
    corners += 1 if area.include?(up) && area.include?(left) && !area.include?(up_left)
    corners += 1 if area.include?(up) && area.include?(right) && !area.include?(up_right)
    corners += 1 if area.include?(down) && area.include?(left) && !area.include?(down_left)
    corners += 1 if area.include?(down) && area.include?(right) && !area.include?(down_right)
  end
  corners
end

@grid = File.readlines('day_12_input.txt').map { |line| line.chomp.chars }
@directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
@visited = Array.new(@grid.size) { Array.new(@grid[0].size, false) }
unique_areas = []

@grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if @visited[i][j]

    area, perimeter = flood_fill(i, j, cell)
    unique_areas << { area: area, perimeter: perimeter, letter: cell } unless area.empty?
  end
end

puts "Part 1: #{unique_areas.sum { |area_info| area_info[:area].size * area_info[:perimeter] }}"
puts "Part 2: #{unique_areas.sum { |area_info| area_info[:area].size * count_corners(area_info[:area]) }}"

@input = []

File.readlines('day_13_input.txt').map(&:chomp).each_slice(4) do |lines|
  ax, ay = lines[0].scan(/X\+(\d+), Y\+(\d+)/)[0].map(&:to_i)
  bx, by = lines[1].scan(/X\+(\d+), Y\+(\d+)/)[0].map(&:to_i)
  px, py = lines[2].scan(/X=(\d+), Y=(\d+)/)[0].map(&:to_i)
  @input << [ax, bx, px, ay, by, py]
end

def find_intersection(ax, bx, px, ay, by, py)
  if @add_offset
    px += 10000000000000
    py += 10000000000000
  end

  determinant = ax * by - ay * bx
  raise("No intersection (lines are parallel or coincident)") if determinant == 0

  # Use Cramer's rule to solve for x and y
  x = (px * by - py * bx).to_f / determinant
  y = (ax * py - ay * px).to_f / determinant
  [x, y]
end

def calculate_move_costs(add_offset)
  @add_offset = add_offset
  sum = 0

  @input.each do |ax, bx, px, ay, by, py|
    x, y = find_intersection(ax, bx, px, ay, by, py)
    sum += (x * 3 + y) if x.to_i == x && y.to_i == y
  end

  sum
end

puts "Part 1: #{calculate_move_costs(false).to_i}"
puts "Part 2: #{calculate_move_costs(true).to_i}"
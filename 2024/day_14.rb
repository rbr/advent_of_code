class Robot
  attr_accessor :position, :velocity

  def initialize(px, py, vx, vy)
    @position = { x: px, y: py }
    @velocity = { x: vx, y: vy }
  end

  def move(grid_width, grid_height)
    @position[:x] = (@position[:x] + @velocity[:x]) % grid_width
    @position[:y] = (@position[:y] + @velocity[:y]) % grid_height
  end

  def to_s
    "Position: X=#{@position[:x]}, Y=#{@position[:y]}"
  end
end

data = File.readlines('day_14_input.txt').map(&:chomp)
@found_tree = false

@robots = data.map do |line|
  px, py, vx, vy = line.scan(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
  Robot.new(px, py, vx, vy)
end

def tick_robots(ticks, grid_width, grid_height)
  ticks.times do |tick|
    @robots.each { |robot| robot.move(grid_width, grid_height) }

    puts "Part 1: #{safety_factor(grid_width, grid_height)}" if tick == 99
    print_grid(tick, grid_width, grid_height)
    break if @found_tree
  end
end

def safety_factor(grid_width, grid_height)
  quadrants = [0, 0, 0, 0]
  mid_x = grid_width / 2
  mid_y = grid_height / 2

  @robots.each do |robot|
    x, y = robot.position[:x], robot.position[:y]
    next if x == mid_x || y == mid_y

    case
    when x > mid_x && y < mid_y then quadrants[0] += 1
    when x < mid_x && y < mid_y then quadrants[1] += 1
    when x < mid_x && y > mid_y then quadrants[2] += 1
    when x > mid_x && y > mid_y then quadrants[3] += 1
    end
  end

  quadrants.reduce(:*)
end

def print_grid(tick, grid_width, grid_height)
  grid = Array.new(grid_height) { Array.new(grid_width, '.') }
  @robots.each do |robot|
    grid[robot.position[:y]][robot.position[:x]] = '@'
  end
  return unless grid.any? { |row| row.join.include?('@@@@@@@@@@@@@@@@@') }

  puts "Part 2: #{tick + 1}"
  grid.each { |row| puts row.join }
  @found_tree = true
end

tick_robots(10000, 101, 103)
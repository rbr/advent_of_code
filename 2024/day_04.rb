
@input = IO.readlines("day_04_input.txt").map { |line| line.chomp.chars }

def letter_found?(location, letter)
  row, col = location
  return false if row < 0 || col < 0 || row >= @input.length || col >= @input[row].length 

  @input[row][col] == letter
end

def word_found?(location, word, direction)
  row, col = location
  return unless @input[row][col] == word[0]

  word[1..-1].chars.each_with_index do |letter, index|
    index += 1
    new_location = 
      case direction
      when :up then [row - index, col]
      when :down then [row + index, col]
      when :left then [row, col - index]
      when :right then [row, col + index]
      when :up_left then [row - index, col - index]
      when :up_right then [row - index, col + index]
      when :down_left then [row + index, col - index]
      when :down_right then [row + index, col + index]
      end

    return false unless letter_found?(new_location, letter)
  end
  true
end

directions = [:up, :down, :left, :right, :up_left, :up_right, :down_left, :down_right]
word = "XMAS"
xmas_count = 0

@input.each_with_index do |row, row_index|
  row.each_with_index do |char, col_index|
    directions.each do |direction|
        xmas_count += 1 if word_found?([row_index, col_index], word, direction)
      end
    end
  end
end

puts "Day 4 Part 1: #{xmas_count}"

def xmas_found?(location)
  row, col = location

  top_left = @input[row - 1][col - 1] 
  top_right = @input[row - 1][col + 1]
  bottom_left = @input[row + 1][col - 1]
  bottom_right = @input[row + 1][col + 1]
  
  [top_left, bottom_right].uniq.sort == ["M", "S"] && [top_right, bottom_left].uniq.sort == ["M", "S"]
end

masmas_count = 0

@input.each_with_index do |row, row_index|
  next if [0, @input.length - 1].include?(row_index)
  row.each_with_index do |char, col_index|
    next if [0, row.length - 1].include?(col_index)
    masmas_count += 1  if char == "A" && xmas_found?([row_index, col_index])
  end
end

puts "Day 4 Part 2: #{masmas_count}"

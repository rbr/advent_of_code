
input = IO.readlines("day_09_input.txt")[0]
computed = []
file_index = 0

input.chars.each_with_index do |number, index|
  number = number.to_i

  if index.even?
    computed << Array.new(number, file_index)
    file_index += 1
  elsif number != 0
    computed << [Array.new(number, nil)]
  end
end

sum = 0
computed_flat = computed.flatten

computed_flat.each_with_index do |number, index|
  if number.nil?
    last_number = computed_flat.pop
    while last_number.nil? do last_number = computed_flat.pop end
    number = last_number
  end
  sum += number * index
end

puts "Part 1: #{sum}"

(computed.size - 1).downto(0).each do |block_index|
  next if computed[block_index][0].class == Array
  file_id = computed[block_index][0]
  size_to_fit = computed[block_index].size
  
  computed.each_with_index do |number_block, move_index|
    break if move_index >= block_index
    next unless number_block[0].class == Array
    has_free_space = number_block[-1][0].nil?
    free_space_size = number_block[-1].size

    if has_free_space && size_to_fit <= free_space_size
      computed[move_index].insert(-2, Array.new(size_to_fit, file_id))
      free_space_left = free_space_size - size_to_fit

      if free_space_left > 0
        computed[move_index][-1] = Array.new(free_space_left, nil)
      else
        computed[move_index].pop
      end

      computed[block_index] = Array.new(size_to_fit, nil)
      break
    end
  end
end

sum = 0

computed.flatten.each_with_index do |number, index|
  next if number.nil?
  sum += number * index
end

puts "Part 2: #{sum}"
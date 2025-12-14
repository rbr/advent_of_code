input = IO.readlines("day_11_input.txt")[0].split(' ')

@stone_counts_cache = {}

def blink(stone)
  if stone == "0"
    "1"
  elsif stone.size.even?
    mid = stone.size / 2
    [stone[0...mid].sub(/^0+/, '').sub(/^$/, '0'), stone[mid..-1].sub(/^0+/, '').sub(/^$/, '0')]
  else
    (stone.to_i * 2024).to_s
  end
end

def count_stones(stone_engraving, blinks)
  return 1 if blinks == 0

  count = @stone_counts_cache[[stone_engraving, blinks]]
  return count if count

  new_stones = *blink(stone_engraving)  
  count = new_stones.sum { |stone| count_stones(stone, blinks - 1) }

  @stone_counts_cache[[stone_engraving, blinks]] = count
  count
end

puts "Part 1: #{input.sum { |stone| count_stones(stone, 25) }}"
puts "Part 2: #{input.sum { |stone| count_stones(stone, 75) }}"
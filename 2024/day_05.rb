require 'tsort'

lines = IO.readlines("day_05_input.txt").map(&:chomp)
separator_index = lines.index { |line| line.strip.empty? }

@ordering_rules = lines[0...separator_index].map { |rule| rule.split("|").map(&:to_i) } 
@updates = lines[(separator_index + 1)..-1].map { |rule| rule.split(",").map(&:to_i) } 
@updates_indexed = @updates.map { |update| update.each_with_object({}).with_index { |(number, hash), index| hash[number] = index } }

correctly_ordered_sum = 0
incorrectly_ordered = []

@updates.each_with_index do |update, index|
  correctly_ordered = true

  @ordering_rules.each do |page_before, page_after|
    page_before_index = @updates_indexed[index][page_before]
    page_after_index = @updates_indexed[index][page_after]
    next unless page_before_index && page_after_index

    if page_before_index > page_after_index
      incorrectly_ordered << update
      correctly_ordered = false
      break
    end
  end
  
  correctly_ordered_sum += update[update.length/2] if correctly_ordered
end

puts "Part 1: #{correctly_ordered_sum}"
  
class NumberSorter
  include TSort # I pity the fool

  def initialize(rules)
    @graph = Hash.new { |hash, key| hash[key] = [] }
    rules.each do |before, after|
      @graph[before] << after
      @graph[after]
    end
  end

  def tsort_each_node(&block)
    @graph.each_key(&block)
  end

  def tsort_each_child(node, &block)
    @graph[node].each(&block)
  end
end

incorrectly_ordered_sum = 0

incorrectly_ordered.sum do |update|
  relevant_rules = @ordering_rules.select { |before, after| update.include?(before) && update.include?(after) }
  sorted_update = NumberSorter.new(relevant_rules).tsort
  incorrectly_ordered_sum += sorted_update[sorted_update.length/2]
end

puts "Part 2: #{incorrectly_ordered_sum}"
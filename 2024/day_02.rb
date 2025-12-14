def safe_report?(report)  
  increasing = report.sort { |a, b| a <=> b }
  decreasing = report.sort { |a, b| b <=> a }
  differences = report.each_cons(2).map { |a, b| (b - a).abs }

  (report == increasing || report == decreasing) && differences.uniq.all? { |diff| diff.between?(1, 3) }
end

def safe_dampened_report?(report)
  report.each_with_index do |_, index|
    dampened_report = report.dup
    dampened_report.delete_at(index)
    return true if safe_report?(dampened_report)
  end
  false
end

safe_reports = 0
safe_dampened_reports = 0

File.foreach('day_02_input.txt') do |line|
  report = line.split.map(&:to_i)

  safe_reports += 1 if safe_report?(report)
  safe_dampened_reports += 1 if safe_dampened_report?(report)
end

puts "Part 1: #{safe_reports}"
puts "Part 2: #{safe_dampened_reports}"
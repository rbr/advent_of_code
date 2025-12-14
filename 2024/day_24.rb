wires, gates = File.read("day_24_input.txt").split(/\n\n/).map { _1.split(/\n/) }
@wires = wires.map { [(wire = _1.split(": "))[0], wire[1].to_i] }.to_h

def process_gate(in1, op, in2, out)
  in1_val, in2_val = @wires[in1], @wires[in2]
  return nil if in1_val.nil? || in2_val.nil?

  @wires[out] =
    case op
    when 'AND' then in1_val & in2_val
    when 'OR' then in1_val | in2_val
    when 'XOR' then in1_val ^ in2_val
    end
end

queue = Queue.new 
gates.each { |gate| queue << gate.split(" ") }

while !queue.empty?
  in1, op, in2, _, out = queue.pop
  queue << [in1, op, in2, _, out] unless process_gate(in1, op, in2, out)
end

# puts @wires.inspect

puts "Part 1: " + @wires.select { |key, _| key.start_with?("z") }.sort.to_h.values.reverse.join.to_i(2).to_s
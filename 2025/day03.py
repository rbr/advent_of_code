from pathlib import Path

INPUT = Path(__file__).parents[2] / "inputs" / "day03.txt"
data = INPUT.read_text().splitlines()

def part1(data):
    total_joltage = 0
    for line in data:
        first_digit = max(line[:-1])
        second_digit = max(line[line.find(first_digit)+1:])
        total_joltage += int(first_digit + second_digit)

    return total_joltage

def part2(data):
    total_joltage = 0
    for line in data:
        joltage = ""
        min_pos = 0

        for index in reversed(range(0, 12)):
            index = None if index == 0 else -index
            value = max(line[min_pos:index])
            joltage += value
            min_pos = line.find(value, min_pos) + 1

        total_joltage += int(joltage)

    return total_joltage

if __name__ == "__main__":
    print("part 1:", part1(data))
    print("part 2:", part2(data))
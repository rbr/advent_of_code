from pathlib import Path

INPUT = Path(__file__).parents[2] / "inputs" / "day01.txt"
data = INPUT.read_text().rstrip("\n")

moves = [
    (-1 if line[0] == "L" else 1) * int(line[1:])
    for line in data.split('\n')
    if line
]

def part1(dial_max: int) -> int:
    dial = 50
    zero_counter = 0

    for move in moves:
        dial = (dial + move) % dial_max
        if dial == 0:
            zero_counter += 1

    return zero_counter

def part2(dial_max: int) -> int:
    dial = 50
    zero_counter = 0

    for move in moves:
        full_rotations, remainder = divmod(abs(move), 100)
        if move < 0:
          new_position = dial - remainder
        else:
          new_position = dial + remainder
        passed_or_landed = int(dial != 0 and not (0 < new_position < 100))
        zero_counter += full_rotations + passed_or_landed
        dial = new_position % 100

    return zero_counter

if __name__ == "__main__":
    print("part 1:", part1(100))
    print("part 2:", part2(100))
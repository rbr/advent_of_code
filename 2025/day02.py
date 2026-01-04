from pathlib import Path

INPUT = Path(__file__).parents[2] / "inputs" / "day02.txt"
data = INPUT.read_text().split(",")

def get_invalid_ids(data: list) -> tuple[int, int]:

    repeated_twice = 0
    repeated = 0

    for entry in data:
        begin, end = entry.split("-")
        begin, end = int(begin), int(end)

        for number in range(begin, end + 1):
            number_str = str(number)
            if len(number_str) > 1:
                max_repeat = len(number_str) // 2

                for i in range(max_repeat, 0, -1):
                    digits = [
                        number_str[j:j+i] for j in range(0, len(number_str), i)
                        ]
                    if len(set(digits)) == 1:
                        repeated += number
                        if i == max_repeat and len(number_str) % 2 == 0:
                            repeated_twice += number
                        break

    return repeated_twice, repeated

if __name__ == "__main__":
    print("part 1 & 2:", get_invalid_ids(data))
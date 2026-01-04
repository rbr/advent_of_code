from pathlib import Path

INPUT = Path(__file__).parents[2] / "inputs" / "day04.txt"
data = INPUT.read_text().splitlines()

ROW_COUNT = len(data)
COL_COUNT = len(data[0])

def count_neighbors(grid: list[str], row: int, col: int) -> int:
    count = 0
    for row_dir in (-1, 0, 1):
        for col_dir in (-1, 0, 1):
            if row_dir == 0 and col_dir == 0:
                continue
            row_check, col_check = row + row_dir, col + col_dir
            if 0 <= row_check < ROW_COUNT and 0 <= col_check < COL_COUNT and grid[row_check][col_check] == "@":
                count += 1
    return count

def part1(data):
    total_free = 0

    for row in range(ROW_COUNT):
        for col in range(COL_COUNT):
            if data[row][col] == "@":
                if count_neighbors(data, row, col) < 4:
                    total_free += 1

    return total_free

def part2(data):
    total_removed = 0
    grid = [list(row) for row in data]

    while True:
        any_removed = False
        for row in range(ROW_COUNT):
            for col in range(COL_COUNT):
                if grid[row][col] == "@":
                    if count_neighbors(grid, row, col) < 4:
                        grid[row][col] = "x"
                        total_removed += 1
                        any_removed = True

        if not any_removed:
            break

    return total_removed

if __name__ == "__main__":
    print("part 1:", part1(data))
    print("part 2:", part2(data))
import AdventOfCode2021
import XCTest

final class Day11Tests: XCTestCase {
    func test_part1_test() {
        XCTAssertEqual(Day11.solvePartOne(from: testInput), 1656)
    }

    func test_part1_solution() {
        XCTAssertEqual(Day11.solvePartOne(from: solutionInput), 1615)
    }

    func test_part2_test() {
        XCTAssertEqual(Day11.solvePartTwo(from: testInput), 195)
    }

    func test_part2_solution() {
        XCTAssertEqual(Day11.solvePartTwo(from: solutionInput), 249)
    }
}

// swiftlint:disable all
private let testInput = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

private let solutionInput = """
4738615556
6744423741
2812868827
8844365624
4546674266
4518674278
7457237431
4524873247
3153341314
3721414667
"""
// swiftlint:enable all

import AdventOfCode2021
import XCTest

final class Day17Tests: XCTestCase {
    func test_part1_test() {
        XCTAssertEqual(Day17.solvePartOne(from: testInput), 45)
    }

    func test_part1_solution() {
        XCTAssertEqual(Day17.solvePartOne(from: solutionInput), 2701)
    }

    func test_part2_test() {
        XCTAssertEqual(Day17.solvePartTwo(from: testInput), 112)
    }

    func test_part2_solution() {
        XCTAssertEqual(Day17.solvePartTwo(from: solutionInput), 1070)
    }
}

// swiftlint:disable all
private let testInput = """
target area: x=20..30, y=-10..-5
"""

private let solutionInput = """
target area: x=281..311, y=-74..-54
"""
// swiftlint:enable all

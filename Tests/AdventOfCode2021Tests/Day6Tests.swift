import AdventOfCode2021
import XCTest

final class Day6Tests: XCTestCase {
    func test_part1_test() {
        XCTAssertEqual(Day6.countLaternfish(from: testInput, for: 18), 26)
        XCTAssertEqual(Day6.betterCountLanternfish(from: testInput, for: 18), 26)
        XCTAssertEqual(Day6.solvePartOne(from: testInput), 5934)
    }

    func test_efficient() {
        XCTAssertEqual(Day6.laternfishProduced(.init(fish: 3, days: 1)), 1)
        XCTAssertEqual(Day6.laternfishProduced(.init(fish: 3, days: 2)), 1)
        XCTAssertEqual(Day6.laternfishProduced(.init(fish: 3, days: 3)), 1)
        XCTAssertEqual(Day6.laternfishProduced(.init(fish: 3, days: 4)), 2)
    }

    func test_part1_solution() {
        XCTAssertEqual(Day6.solvePartOne(from: solutionInput), 360761)
    }

    func test_part2_test() {
        XCTAssertEqual(Day6.solvePartTwo(from: testInput), 26984457539)
    }

    func test_part2_solution() {
        XCTAssertEqual(Day6.solvePartTwo(from: solutionInput), 1632779838045)
    }
}

// swiftlint:disable all
private let testInput = """
3,4,3,1,2
"""

private let solutionInput = """
2,1,1,4,4,1,3,4,2,4,2,1,1,4,3,5,1,1,5,1,1,5,4,5,4,1,5,1,3,1,4,2,3,2,1,2,5,5,2,3,1,2,3,3,1,4,3,1,1,1,1,5,2,1,1,1,5,3,3,2,1,4,1,1,1,3,1,1,5,5,1,4,4,4,4,5,1,5,1,1,5,5,2,2,5,4,1,5,4,1,4,1,1,1,1,5,3,2,4,1,1,1,4,4,1,2,1,1,5,2,1,1,1,4,4,4,4,3,3,1,1,5,1,5,2,1,4,1,2,4,4,4,4,2,2,2,4,4,4,2,1,5,5,2,1,1,1,4,4,1,4,2,3,3,3,3,3,5,4,1,5,1,4,5,5,1,1,1,4,1,2,4,4,1,2,3,3,3,3,5,1,4,2,5,5,2,1,1,1,1,3,3,1,1,2,3,2,5,4,2,1,1,2,2,2,1,3,1,5,4,1,1,5,3,3,2,2,3,1,1,1,1,2,4,2,2,5,1,2,4,2,1,1,3,2,5,5,3,1,3,3,1,4,1,1,5,5,1,5,4,1,1,1,1,2,3,3,1,2,3,1,5,1,3,1,1,3,1,1,1,1,1,1,5,1,1,5,5,2,1,1,5,2,4,5,5,1,1,5,1,5,5,1,1,3,3,1,1,3,1
"""
// swiftlint:enable all

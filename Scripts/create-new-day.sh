#!/bin/bash

day=$1
cat > "Sources/AdventOfCode2021/Day${day}.swift" << SWIFT
public enum Day${day} {
    public static func solvePartOne(from input: String) -> Int {
        0
    }

    public static func solvePartTwo(from input: String) -> Int {
        0
    }
}
SWIFT

cat > "Tests/AdventOfCode2021Tests/Day${day}Tests.swift" << SWIFT
import AdventOfCode2021
import XCTest

final class Day${day}Tests: XCTestCase {
    func test_part1_test() {
        XCTAssertEqual(Day${day}.solvePartOne(from: testInput), 1)
    }

    func test_part1_solution() {
        XCTAssertEqual(Day${day}.solvePartOne(from: solutionInput), 1)
    }

    func test_part2_test() {
        XCTAssertEqual(Day${day}.solvePartTwo(from: testInput), 1)
    }

    func test_part2_solution() {
        XCTAssertEqual(Day${day}.solvePartTwo(from: solutionInput), 1)
    }
}

private let testInput = """

"""

private let solutionInput = """

"""
SWIFT
swift test --generate-linuxmain

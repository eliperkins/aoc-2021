import AdventOfCode2021
import XCTest

final class Day12Tests: XCTestCase {
    func test_part1_test() {
        XCTAssertEqual(Day12.solvePartOne(from: testInputSmall), 10)
        XCTAssertEqual(Day12.solvePartOne(from: testInputMedium), 19)
        XCTAssertEqual(Day12.solvePartOne(from: testInputLarge), 226)
    }

    func test_part1_solution() {
        XCTAssertEqual(Day12.solvePartOne(from: solutionInput), 3856)
    }

    func test_part2_test() {
        XCTAssertEqual(Day12.solvePartTwo(from: testInputSmall), 36)
        XCTAssertEqual(Day12.solvePartTwo(from: testInputMedium), 103)
        XCTAssertEqual(Day12.solvePartTwo(from: testInputLarge), 3509)
    }

    func test_part2_solution() {
        XCTAssertEqual(Day12.solvePartTwo(from: solutionInput), 116692)
    }
}

// swiftlint:disable all
private let testInputSmall = """
start-A
start-b
A-c
A-b
b-d
A-end
b-end
"""

private let testInputMedium = """
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
"""

private let testInputLarge = """
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
"""

private let solutionInput = """
qi-UD
jt-br
wb-TF
VO-aa
UD-aa
br-end
end-HA
qi-br
br-HA
UD-start
TF-qi
br-hf
VO-hf
start-qi
end-aa
hf-HA
hf-UD
aa-hf
TF-hf
VO-start
wb-aa
UD-wb
KX-wb
qi-VO
br-TF
"""
// swiftlint:enable all

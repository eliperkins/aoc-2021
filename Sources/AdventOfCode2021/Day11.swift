public enum Day11 {

    struct FlashStepSequence: Sequence {
        let initial: Matrix<Int>

        func makeIterator() -> FlashIterator {
            FlashIterator(current: initial)
        }
    }

    struct FlashIterator: IteratorProtocol {
        var current: Matrix<Int>

        mutating func next() -> (Matrix<Int>, Int)? {
            var increased = current.map { value, _ in value + 1 }
            var flashed = Set<Point>()

            func flashIfNeeded(value: Int, at point: Point) {
                if value > 9 && flashed.insert(point).inserted {
                    point.adjecent.forEach { point in
                        if let value = increased.at(point) {
                            increased.set(
                                value: value + 1,
                                point: point
                            )
                            flashIfNeeded(value: value + 1, at: point)
                        }
                    }
                }
            }

            increased.forEachPosition { value, position in
                let point = Point(position)
                flashIfNeeded(value: value, at: point)
            }

            let next = increased
                .map { value, _ -> Int in
                    if value > 9 {
                        return 0
                    }
                    return value
                }
            current = next
            return (next, flashed.count)
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        let matrix = Matrix(input.lines.map { line in line.compactMap { Int(String($0)) } })

        return FlashStepSequence(initial: matrix)
            .prefix(100)
            .reduce(0) { acc, next in
                acc + next.1
            }
    }

    public static func solvePartTwo(from input: String) -> Int {
        let matrix = Matrix(input.lines.map { line in line.compactMap { Int(String($0)) } })
        let size = matrix.rows.count * matrix.columns.count
        return FlashStepSequence(initial: matrix)
            .enumerated()
            .first { _, value in value.1 == size }!
            .0 + 1
    }
}

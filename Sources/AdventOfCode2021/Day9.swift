public enum Day9 {
    static func positionsAdjecent(to position: Point) -> [Point] {
        [
            Point(x: position.x + 1, y: position.y),
            Point(x: position.x - 1, y: position.y),
            Point(x: position.x, y: position.y + 1),
            Point(x: position.x, y: position.y - 1)
        ]
    }

    public static func solvePartOne(from input: String) -> Int {
        let matrix = Matrix(input.lines.map { line in
            line.compactMap { Int(String($0)) }
        })

        return matrix
            .collect { item, position in
                positionsAdjecent(to: Point(x: position.x, y: position.y))
                    .compactMap { matrix.atPosition(x: $0.x, y: $0.y) }
                    .allSatisfy { $0 > item }
            }
            .reduce(0, { acc, next in
                acc + (next + 1)
            })
    }

    public static func solvePartTwo(from input: String) -> Int {
        let matrix = Matrix(input.lines.map { line in
            line.compactMap { Int(String($0)) }
        })

        let lowpoints = matrix
            .collectLocations { item, position in
                positionsAdjecent(to: Point(x: position.x, y: position.y))
                    .compactMap { matrix.atPosition(x: $0.x, y: $0.y) }
                    .allSatisfy { $0 > item }
            }

        func traverseBasin(from position: Point, accumulator: inout Set<Point>) {
            accumulator.insert(position)

            let adjecent = positionsAdjecent(to: position)
            let positions = adjecent
                .filter {
                    guard let value = matrix.atPosition(x: $0.x, y: $0.y) else { return false }
                    return value != 9 && !accumulator.contains($0)
                }

            if positions.isEmpty {
                return
            }

            for position in positions {
                accumulator.insert(position)

                traverseBasin(
                    from: position,
                    accumulator: &accumulator
                )
            }
        }

        func basin(from position: Point) -> Set<Point> {
            var accumulator = Set<Point>()
            traverseBasin(from: position, accumulator: &accumulator)
            return accumulator
        }

        return lowpoints
            .map { basin(from: Point(x: $1.x, y: $1.y)).count }
            .sorted()
            .suffix(3)
            .reduce(1, *)
    }
}

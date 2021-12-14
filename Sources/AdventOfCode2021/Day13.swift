public enum Day13 {
    public static func solvePartOne(from input: String, numFolds: Int = .max) -> Int {
        let lines = input.lines.split(whereSeparator: \.isEmpty)
        let points = lines.first!.map { line -> Point in
            let parts = String(line).split(separator: ",")
            let x = Int(String(parts.first!))!
            let y = Int(String(parts.last!))!
            return Point(x: x, y: y)
        }

        let folds = lines.last!.map { line -> (PartialKeyPath<Point>, Int) in
            let parts = line.dropFirst("fold along ".count).split(separator: "=")
            let axis: PartialKeyPath<Point> = parts.first! == "x" ? \.x : \.y
            let position = Int(String(parts.last!))!
            return (axis, position)
        }

        let result = folds.prefix(numFolds).reduce(Set(points)) { acc, fold in
            let (axis, position) = fold
            switch axis {
            case \.x:
                return acc.filter { $0.x < position }
                    .union(
                        acc.filter { $0.x > position }.map {
                            Point(x: position - ($0.x - position), y: $0.y)
                        }
                    )
            case \.y:
                return acc.filter { $0.y < position }
                    .union(
                        acc.filter { $0.y > position }.map {
                            Point(x: $0.x, y: position - ($0.y - position))
                        }
                    )
            default:
                return []
            }
        }

        if numFolds == .max {
            let maxX = result.max(by: { $0.x < $1.x })!.x
            let maxY = result.max(by: { $0.y < $1.y })!.y

            var matrix = Matrix<String>(
                Array(repeating: Array(repeating: ".", count: maxX + 1), count: maxY + 1)
            )

            result.forEach {
                matrix.set(value: "#", point: $0)
            }

            print(matrix.rows.map { $0.joined() }.joined(separator: "\n"))
        }

        return result.count
    }

    public static func solvePartTwo(from input: String) -> Int {
        0
    }
}

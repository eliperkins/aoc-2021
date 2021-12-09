import Foundation

public enum Day5 {
    static func solve(_ input: String, includeDiagonals: Bool) -> Int {
        let points: [[Point]] = input.lines.map { line in
            let linePoint = line.components(separatedBy: " -> ")
            let startValues = linePoint.first!.split(separator: ",")
            let startPoint = Point(x: Int(startValues.first!)!, y: Int(startValues.last!)!)
            let endValues = linePoint.last!.split(separator: ",")
            let endPoint = Point(x: Int(endValues.first!)!, y: Int(endValues.last!)!)

            if startPoint.x == endPoint.x {
                let startY = min(startPoint.y, endPoint.y)
                let endY = max(startPoint.y, endPoint.y)
                return (startY...endY).map {
                    Point(x: startPoint.x, y: $0)
                }
            } else if startPoint.y == endPoint.y {
                let startX = min(startPoint.x, endPoint.x)
                let endX = max(startPoint.x, endPoint.x)
                return (startX...endX).map {
                    Point(x: $0, y: startPoint.y)
                }
            } else if includeDiagonals {
                let xs = stride(
                    from: startPoint.x,
                    through: endPoint.x,
                    by: startPoint.x < endPoint.x ? 1 : -1
                )
                let ys = stride(
                    from: startPoint.y,
                    through: endPoint.y,
                    by: startPoint.y < endPoint.y ? 1 : -1
                )
                assert(xs.underestimatedCount == ys.underestimatedCount)
                let points = zip(xs, ys).map { Point(x: $0, y: $1) }
                assert(points.first == startPoint)
                assert(points.last == endPoint)
                return points
            } else {
                return []
            }
        }

        let counts = Dictionary(grouping: points.flatMap { $0 }, by: { $0 })
        return counts.reduce(0) { acc, next in
            if next.value.count > 1 {
                return acc + 1
            }
            return acc
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        solve(input, includeDiagonals: false)
    }

    public static func solvePartTwo(from input: String) -> Int {
        solve(input, includeDiagonals: true)
    }
}

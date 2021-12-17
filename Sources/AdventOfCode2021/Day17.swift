import Algorithms

public enum Day17 {
    struct VelocitySequence: Sequence {
        let initialVelocity: Point

        func makeIterator() -> VelocityPointIterator {
            return VelocityPointIterator(
                currentVelocity: initialVelocity,
                currentPoint: Point(x: 0, y: 0)
            )
        }
    }

    struct VelocityPointIterator: IteratorProtocol {
        var currentVelocity: Point
        var currentPoint: Point

        mutating func next() -> Point? {
            let nextPoint = Point(
                x: currentPoint.x + currentVelocity.x,
                y: currentPoint.y + currentVelocity.y
            )

            let nextVelocityX: Int
            if currentVelocity.x > 0 {
                nextVelocityX = currentVelocity.x - 1
            } else if currentVelocity.x < 0 {
                nextVelocityX = currentVelocity.x + 1
            } else {
                nextVelocityX = 0
            }

            let nextVelocityY = currentVelocity.y - 1

            currentPoint = nextPoint
            currentVelocity = Point(
                x: nextVelocityX,
                y: nextVelocityY
            )

            return nextPoint
        }
    }

    static func ranges(from input: String) -> (xRange: ClosedRange<Int>, yRange: ClosedRange<Int>) {
        let parts = input.split(separator: " ")
        let xRangeParts = parts.first(where: { $0.starts(with: "x") })!.dropFirst(2).dropLast()
            .replacingOccurrences(of: "..", with: " ")
            .split(separator: " ")
        let yRangeParts = parts.first(where: { $0.starts(with: "y") })!.dropFirst(2)
            .replacingOccurrences(of: "..", with: " ")
            .split(separator: " ")
        return (
            Int(xRangeParts.first!)!...Int(xRangeParts.last!)!,
            Int(yRangeParts.first!)!...Int(yRangeParts.last!)!
        )
    }

    static func sequencesIntersecting(
        xRange: ClosedRange<Int>,
        yRange: ClosedRange<Int>,
        xVelocities: ClosedRange<Int>,
        yVelocities: ClosedRange<Int>
    ) -> [[Point]] {
        return product(xVelocities, yVelocities)
            .map { tuple in
                VelocitySequence(initialVelocity: Point(x: tuple.0, y: tuple.1))
                    .prefix(while: { $0.x <= xRange.upperBound && yRange.lowerBound <= $0.y })
            }
            .filter { sequence in
                sequence.contains(where: { xRange.contains($0.x) && yRange.contains($0.y) })
            }
    }

    public static func solvePartOne(from input: String) -> Int {
        let (xRange, yRange) = ranges(from: input)

        let xs = 1...xRange.upperBound
        let ys = 0...xRange.lowerBound

        return sequencesIntersecting(xRange: xRange, yRange: yRange, xVelocities: xs, yVelocities: ys)
            .flatMap { sequence in
                sequence.map(\.y)
            }
            .max()!
    }

    public static func solvePartTwo(from input: String) -> Int {
        let (xRange, yRange) = ranges(from: input)

        let xs = 1...xRange.upperBound
        let ys = yRange.lowerBound...xRange.lowerBound

        return sequencesIntersecting(xRange: xRange, yRange: yRange, xVelocities: xs, yVelocities: ys)
            .count
    }
}

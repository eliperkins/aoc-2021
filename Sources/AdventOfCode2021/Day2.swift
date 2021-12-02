public enum Day2 {
    enum Direction: String {
        case forward
        case down
        case up
    }

    struct Movement {
        let direction: Direction
        let value: Int
    }

    struct Position {
        var horizontal: Int
        var depth: Int
        var aim: Int
    }

    private static func parseMovements(from input: String) -> [Movement] {
        input.lines.compactMap { line in
            let parts = line.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)

            guard let direction = parts.first.flatMap(String.init).flatMap(Direction.init(rawValue:)),
                    let value = parts.last.flatMap(String.init).flatMap(Int.init)
            else { return nil }

            return Movement(direction: direction, value: value)
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        let position = parseMovements(from: input)
            .reduce(into: Position(horizontal: 0, depth: 0, aim: 0), { acc, next in
                switch next.direction {
                case .up:
                    acc.depth -= next.value
                case .down:
                    acc.depth += next.value
                case .forward:
                    acc.horizontal += next.value
                }
            })

        return position.depth * position.horizontal
    }

    public static func solvePartTwo(from input: String) -> Int {
        let position = parseMovements(from: input)
            .reduce(into: Position(horizontal: 0, depth: 0, aim: 0), { acc, next in
                switch next.direction {
                case .up:
                    acc.aim -= next.value
                case .down:
                    acc.aim += next.value
                case .forward:
                    acc.horizontal += next.value
                    acc.depth += acc.aim * next.value
                }
            })

        return position.depth * position.horizontal
    }
}

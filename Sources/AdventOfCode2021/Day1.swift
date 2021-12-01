import Algorithms

public enum Day1 {
    public static func solve(_ input: String) -> Int {
        let values = input.lines.compactMap(Int.init)
        return values.windows(ofCount: 2).reduce(0) { acc, next in
            guard let lhs = next.first, let rhs = next.last else { return acc }

            if lhs < rhs {
                return acc + 1
            }

            return acc
        }
    }

    public static func solvePartTwo(_ input: String) -> Int {
        let values = input.lines.compactMap(Int.init)
        let xs = values.windows(ofCount: 3).map { $0.reduce(0, +) }
        return xs.windows(ofCount: 2).reduce(0) { acc, next in
            guard let lhs = next.first, let rhs = next.last else { return acc }

            if lhs < rhs {
                return acc + 1
            }

            return acc
        }
    }
}

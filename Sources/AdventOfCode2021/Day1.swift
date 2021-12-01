public enum Day1 {
    public static func solve(_ input: String) -> Int {
        let values = input.lines.compactMap(Int.init)
        let pairs = zip(values, values.dropFirst())
        return pairs.reduce(0) { acc, next in
            if next.0 < next.1 {
                return acc + 1
            }
            return acc
        }
    }

    public static func solvePartTwo(_ input: String) -> Int {
        let values = input.lines.compactMap(Int.init)
        let xs = zip(values, zip(values.dropFirst(), values.dropFirst().dropFirst())).map {
            $0.0 + $0.1.0 + $0.1.1
        }
        let pairs = zip(xs, xs.dropFirst())
        return pairs.reduce(0) { acc, next in
            if next.0 < next.1 {
                return acc + 1
            }
            return acc
        }
    }
}

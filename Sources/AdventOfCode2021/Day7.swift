public enum Day7 {
    public static func solvePartOne(from input: String) -> Int {
        let positions = input.split(separator: ",").compactMap { Int(String($0)) }
        let range = (positions.min()!)...(positions.max()!)
        return range.map { exitNum in
            positions.reduce(0) { acc, next in
                acc + calculateStaticCost(for: next, to: exitNum)
            }
        }.min() ?? 0
    }

    static func calculateStaticCost(for crab: Int, to exit: Int) -> Int {
        if exit > crab {
            return exit - crab
        }

        return crab - exit
    }

    static func calculateLinearCost(for crab: Int, to exit: Int) -> Int {
        let steps = calculateStaticCost(for: crab, to: exit)
        // use triangle number for cost
        return Int((steps * (steps + 1)) / 2)
    }

    public static func solvePartTwo(from input: String) -> Int {
        let positions = input.split(separator: ",").compactMap { Int(String($0)) }
        let range = (positions.min()!)...(positions.max()!)
        return range.map { exitNum in
            positions.reduce(0) { acc, next in
                acc + calculateLinearCost(for: next, to: exitNum)
            }
        }.min() ?? 0
    }
}

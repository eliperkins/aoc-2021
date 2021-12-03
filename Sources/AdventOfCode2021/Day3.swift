public enum Day3 {

    struct Rate {
        let gamma: [Int]
        let epsilon: [Int]
    }

    struct Matrix {
        private let storage: [[Int]]

        init(_ xs: [[Int]]) {
            storage = xs
        }

        var rows: [[Int]] {
            storage
        }

        var columns: [[Int]] {
            storage[0].indices.map { index in
                storage.map { $0[index] }
            }
        }
    }

    static func createMatrix(from input: String) -> Matrix {
        Matrix(
            input.lines.map { line in
                line.compactMap(String.init).compactMap(Int.init)
            }
        )
    }

    static func calculateRate(from matrix: Matrix) -> Rate {
        matrix.columns.reduce(Rate(gamma: [], epsilon: [])) { acc, next in
            let counts = Dictionary(grouping: next, by: { $0 })
            let zeros = counts[0]?.count ?? 0
            let ones = counts[1]?.count ?? 0
            if zeros > ones {
                return Rate(gamma: acc.gamma + [0], epsilon: acc.epsilon + [1])
            } else {
                return Rate(gamma: acc.gamma + [1], epsilon: acc.epsilon + [0])
            }
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        let matrix = createMatrix(from: input)
        let rates = calculateRate(from: matrix)

        guard let gamma = Int(rates.gamma.map(String.init).joined(), radix: 2),
              let epsilon = Int(rates.epsilon.map(String.init).joined(), radix: 2)
        else { return 0 }

        return gamma * epsilon
    }

    public static func solvePartTwo(from input: String) -> Int {
        let matrix = createMatrix(from: input)

        let oxygen: Int = {
            var oxygenValues = matrix.rows
            var offset = 0
            while oxygenValues.count > 1 {
                let rates = calculateRate(from: Matrix(oxygenValues))
                oxygenValues = oxygenValues.filter {
                    $0[offset] == rates.gamma[offset]
                }
                offset += 1
            }

            return Int(oxygenValues.first!.map(String.init).joined(), radix: 2) ?? 0
        }()

        let co2: Int = {
            var co2Values = matrix.rows
            var offset = 0
            while co2Values.count > 1 {
                let rates = calculateRate(from: Matrix(co2Values))
                co2Values = co2Values.filter {
                    $0[offset] == rates.epsilon[offset]
                }
                offset += 1
            }

            return Int(co2Values.first!.map(String.init).joined(), radix: 2) ?? 0
        }()

        return oxygen * co2
    }
}

import Algorithms

public enum Day8 {
    public static func solvePartOne(from input: String) -> Int {
        input.lines.flatMap {
            String($0.split(separator: "|").last!).split(separator: " ")
        }
        .filter {
            switch $0.count {
            case 2, 3, 4, 7:
                return true
            default:
                return false
            }
        }
        .count
    }

    public static func solvePartTwo(from input: String) -> Int {
        input.lines.map { line -> Int in
            let parts = line.split(separator: "|")
            let inputs = parts.first!
                .trimmingCharacters(in: .whitespaces)
                .split(separator: " ")
                .map(String.init)
            let outputs = parts.last!
                .trimmingCharacters(in: .whitespaces)
                .split(separator: " ")
                .map(String.init)

            assert(inputs.count == 10)
            assert(outputs.count == 4)

            let byCount = Dictionary(grouping: inputs, by: \.count)

            let fours = byCount[4]!.first!
            let eights = byCount[7]!.first!
            let threes = byCount[5]!.first(where: { Set($0).isSuperset(of: Set(ones)) })!
            let fives = byCount[5]!.first(where: { Set($0).isSuperset(of: Set(fours).subtracting(Set(sevens))) })!
            let twos = byCount[5]!.first(where: { Set($0).isSuperset(of: Set(eights).subtracting(Set(fives))) })!
            let nines = byCount[6]!.first(where: { Set($0) == Set(fives).union(Set(ones)) })!
            let sixes = byCount[6]!.first(where: {
                Set($0).isSuperset(of: Set(eights).subtracting(Set(sevens)))
            })!
            let zeros = byCount[6]!.first(where: {
                Set($0).isSuperset(of: Set(twos).subtracting(Set(fives)).union(Set(fives).subtracting(twos)))
            })!

            let lookupMap = [
                Set(zeros): 0,
                Set(ones): 1,
                Set(twos): 2,
                Set(threes): 3,
                Set(fours): 4,
                Set(fives): 5,
                Set(sixes): 6,
                Set(sevens): 7,
                Set(eights): 8,
                Set(nines): 9
            ]

            return Int(outputs.reduce("") { acc, next in
                acc + String(lookupMap[Set(next)]!)
            })!
        }
        .reduce(0, +)
    }
}

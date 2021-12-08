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
            let inputs = parts.first!.trimmingCharacters(in: .whitespaces).split(separator: " ").map(String.init)
            let outputs = parts.last!.trimmingCharacters(in: .whitespaces).split(separator: " ").map(String.init)
            assert(inputs.count == 10)
            assert(outputs.count == 4)

            let byCount = Dictionary(grouping: inputs, by: \.count)

            var positions = Array<Character>(repeating: "a", count: 7)

            let ones = byCount[2]!.first!
            positions[2] = ones.first!
            positions[5] = ones.last!

            let sevens = byCount[3]!.first!
            let top = Set(sevens).subtracting(Set(ones)).first!
            positions[0] = top

            let fours = byCount[4]!.first!
            let topLeftAndMiddle = String(Set(fours).subtracting(Set(ones)))

            let eights = byCount[7]!.first!
            let bottomLeftAndBottom = String(Set(eights).subtracting(Set(sevens)).subtracting(Set(fours)))

            let possiblePermutations: [[Character]] = [
                [topLeftAndMiddle.first!, topLeftAndMiddle.last!, bottomLeftAndBottom.first!, bottomLeftAndBottom.last!],
                [topLeftAndMiddle.first!, topLeftAndMiddle.last!, bottomLeftAndBottom.last!, bottomLeftAndBottom.first!],
                [topLeftAndMiddle.last!, topLeftAndMiddle.first!, bottomLeftAndBottom.first!, bottomLeftAndBottom.last!],
                [topLeftAndMiddle.last!, topLeftAndMiddle.first!, bottomLeftAndBottom.last!, bottomLeftAndBottom.first!]
            ]

            let solutions: [[Character]] = possiblePermutations.map { permutation in
                var mutable = positions
                mutable[1] = permutation[0]
                mutable[3] = permutation[1]
                mutable[4] = permutation[2]
                mutable[6] = permutation[3]
                return mutable
            }

            let lookupMap: Dictionary<Int, Set<Character>> = solutions.map { solution in
                var lookupMap = Dictionary<Int, Set<Character>>()

                lookupMap[0] = Set(eights).subtracting([solution[3]])
                lookupMap[1] = Set(ones)
                lookupMap[2] = Set(eights).subtracting([solution[1], solution[5]])
                lookupMap[3] = Set(eights).subtracting([solution[1], solution[4]])
                lookupMap[4] = Set(fours)
                lookupMap[5] = Set(eights).subtracting([solution[2], solution[4]])
                lookupMap[6] = Set(eights).subtracting([solution[2]])
                lookupMap[7] = Set(sevens)
                lookupMap[8] = Set(eights)
                lookupMap[9] = Set(eights).subtracting([solution[4]])

                return lookupMap
            }.first(where: { map in
                assert(map.keys.count == map.values.count)
                let reverseLookup = Dictionary(zip(map.values, map.keys), uniquingKeysWith: { lhs, rhs in lhs })
                print(Dictionary(grouping: inputs, by: { reverseLookup[Set($0)] != nil }))
                return inputs.allSatisfy { reverseLookup[Set($0)] != nil }
            })!

            let reverseLookup = Dictionary(zip(lookupMap.values, lookupMap.keys), uniquingKeysWith: { lhs, rhs in lhs })
            print(reverseLookup)
            return Int(outputs.reduce("") { acc, next in
                acc + String(reverseLookup[Set(next)]!)
            })!
        }
        .reduce(0, +)
    }
}

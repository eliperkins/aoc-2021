import Algorithms

public enum Day14 {

    static func polymerize(input: String, times: Int) -> Int {
        let parts = input.lines.split(maxSplits: 1, whereSeparator: \.isEmpty)
        let template = String(parts.first!.first!)
        let insertionRuleValues = parts.last!.map { line -> (String, Character) in
            let rule = String(line)
            let match = String(rule.prefix(2))
            let insertion = rule.suffix(1).first!
            return (match, insertion)
        }
        let rules = Dictionary(uniqueKeysWithValues: insertionRuleValues)
        let initial = template.windows(ofCount: 2)
            .map { String($0) }
            .reduce(into: [:]) { acc, next in
                acc[next, default: 0] += 1
            }

        let polymer = (0..<times).reduce(initial) { acc, _ in
            var mutable = acc
            for (pair, value) in acc {
                if let insertionValue = rules[pair] {
                    mutable[pair, default: 0] -= value
                    let keys = [String([pair.first!, insertionValue]), String([insertionValue, pair.last!])]
                    for key in keys {
                        mutable[key, default: 0] += value
                    }
                }
            }
            return mutable
        }

        var counts = polymer.reduce(into: [Character: Int]()) { acc, next in
            let (key, value) = next
            for char in key {
                acc[char, default: 0] += value
            }
        }

        // first and last characters are not duplicated in pairs from windowing
        counts[template.first!, default: 0] -= 1
        counts[template.last!, default: 0] -= 1

        counts = counts.mapValues { $0 / 2 }

        counts[template.first!, default: 0] += 1
        counts[template.last!, default: 0] += 1

        let (min, max) = counts.values.minAndMax()!
        return max - min
    }

    public static func solvePartOne(from input: String) -> Int {
        polymerize(input: input, times: 10)
    }

    public static func solvePartTwo(from input: String) -> Int {
        polymerize(input: input, times: 40)
    }
}

import Collections

public enum Day10 {
    static let pairs: [Character: Character] = [
        ")": "(",
        "]": "[",
        "}": "{",
        ">": "<"
    ]

    public static func solvePartOne(from input: String) -> Int {
        let scores: [Character: Int] = [
            ")": 3,
            "]": 57,
            "}": 1197,
            ">": 25137
        ]
        return input.lines.map { line in
            var deque = Deque<Character>()
            for character in line {
                switch character {
                case "(", "[", "{", "<":
                    deque.append(character)
                case ")", "]", "}", ">":
                    guard let match = deque.popLast() else {
                        return 0
                    }

                    if Self.pairs[character] != match {
                        return scores[character] ?? 0
                    }
                default:
                    fatalError()
                }
            }

            return 0
        }
        .reduce(0, +)
    }

    public static func solvePartTwo(from input: String) -> Int {
        let characterScores: [Character: Int] = [
            "(": 1,
            "[": 2,
            "{": 3,
            "<": 4
        ]
        let lineScores: [Int] = input.lines.compactMap { line in
            var deque = Deque<Character>()

            for character in line {
                switch character {
                case "(", "[", "{", "<":
                    deque.append(character)
                case ")", "]", "}", ">":
                    if deque.popLast() != Self.pairs[character] {
                        return nil
                    }
                default:
                    fatalError()
                }
            }

            return deque.reversed().reduce(0) { (acc: Int, next) in
                return acc * 5 + characterScores[next, default: 0]
            }
        }

        if scores.isEmpty {
            return 0
        }

        return scores.sorted()[Int((scores.count - 1) / 2)]
    }
}

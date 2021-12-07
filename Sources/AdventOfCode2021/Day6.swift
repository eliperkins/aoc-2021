public enum Day6 {
    public static func countLaternfish(from input: String, for days: Int) -> Int {
        var fishes = input.split(separator: ",").compactMap { Int(String($0)) }
        (0..<days).forEach { _ in
            let fishToAdd = fishes.filter { $0 == 0 }.count
            fishes = fishes.map { $0 == 0 ? 6 : $0 - 1 }
                + Array(repeating: 8, count: fishToAdd)
        }
        return fishes.count
    }

    public struct Input: Hashable {
        public let fish: Int
        public let days: Int

        public init(fish: Int, days: Int) {
            self.fish = fish
            self.days = days
        }
    }

    static func recursiveMemoize<Input: Hashable, Output>(_ function: @escaping ((Input) -> Output, Input) -> Output) -> (Input) -> Output {
        var storage = [Input: Output]()
        var memo: ((Input) -> Output)!
        memo = { input in
            if let cached = storage[input] {
                return cached
            }

            let result = function(memo, input)
            storage[input] = result
            return result
        }
        return memo
    }

    public static let laternfishProduced: (Input) -> Int = recursiveMemoize { (calc: ((Input) -> Int), input: Input) in
        let x = input.days - input.fish
        if x > 0 {
            return calc(Input(fish: 6, days: x - 1))
                + calc(Input(fish: 8, days: x - 1))
        } else {
            return 1
        }
    }

    public static func betterCountLanternfish(from input: String, for days: Int) -> Int {
        let fishes = input.split(separator: ",").compactMap { Int(String($0)) }
        return fishes.reduce(0) { acc, next in
            acc + laternfishProduced(Input(fish: next, days: days))
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        betterCountLanternfish(from: input, for: 80)
    }

    public static func solvePartTwo(from input: String) -> Int {
        betterCountLanternfish(from: input, for: 256)
    }
}

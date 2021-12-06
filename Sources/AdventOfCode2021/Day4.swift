public enum Day4 {
    final class Board: CustomDebugStringConvertible {
        struct Cell {
            let value: Int
            var marked: Bool
        }

        var cells: Matrix<Cell>

        init(_ stringValues: [String]) {
            assert(stringValues.count == 5)
            self.cells = Matrix(
                stringValues.map { line in
                    line.split(whereSeparator: \.isWhitespace)
                        .compactMap { Int(String($0)) }
                        .map { Cell(value: $0, marked: false) }
                }
            )
        }

        var isWinning: Bool {
            cells.rows.contains(where: { $0.allSatisfy(\.marked) })
                || cells.columns.contains(where: { $0.allSatisfy(\.marked) })
        }

        var winningValue: Int {
            cells.rows.reduce(0) { acc, next in
                return acc + next.reduce(0) { innerAcc, cell in
                    return cell.marked
                        ? innerAcc
                        : innerAcc + cell.value
                }
            }
        }

        func mark(value: Int) {
            self.cells = Matrix(cells.rows.map { row in
                row.map {
                    var mut = $0

                    if mut.value == value {
                        mut.marked = true
                    }

                    return mut
                }
            })
        }

        var debugDescription: String {
            cells.rows.map { row in
                row
                    .map {
                        if $0.marked {
                            return "(\($0.value))"
                        }
                        return String($0.value)
                    }
                    .joined(separator: ",")
            }
            .joined(separator: "\n")
        }
    }

    final class Game {
        let inputs: [Int]
        var boards: [Board]

        init(inputs: [Int], boards: [Board]) {
            self.inputs = inputs
            self.boards = boards
        }

        init(_ stringInput: String) {
            self.inputs = stringInput.lines.first!.split(separator: ",").compactMap { Int(String($0)) }
            self.boards = stringInput.lines.dropFirst().split(whereSeparator: \.isEmpty)
                .map { Board(Array($0)) }
        }

        func run() -> (Int, Board)? {
            for input in inputs {
                for board in boards {
                    board.mark(value: input)
                }

                if let winningBoard = boards.first(where: \.isWinning) {
                    return (input, winningBoard)
                }
            }

            return nil
        }

        func runPartTwo() -> (Int, Board)? {
            var lastBoardToWin: Board?

            for input in inputs {
                for board in boards {
                    board.mark(value: input)
                }

                let nonWinningBoard = boards.first(where: { !$0.isWinning })
                if nonWinningBoard == nil, let lastBoardToWin = lastBoardToWin {
                    return (input, lastBoardToWin)
                } else {
                    lastBoardToWin = nonWinningBoard
                }
            }

            return nil
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        let game = Game(input)
        let winner = game.run()

        if let (winningNumber, winningBoard) = winner {
            return winningNumber * winningBoard.winningValue
        }

        return 0
    }

    public static func solvePartTwo(from input: String) -> Int {
        let game = Game(input)
        let winner = game.runPartTwo()

        if let (winningNumber, winningBoard) = winner {
            return winningNumber * winningBoard.winningValue
        }

        return 0
    }
}

import GameKit

public enum Day15 {
    private static func findCost(for matrix: Matrix<Int>) -> Int {
        final class ChitonNode: GKGridGraphNode {
            var chitonCost: Int = 1

            override func estimatedCost(to node: GKGraphNode) -> Float {
                guard let chitonNode = node as? ChitonNode else { return Float(chitonCost) }
                let dx = abs(Float(gridPosition.x) - Float(chitonNode.gridPosition.x))
                let dy = abs(Float(gridPosition.y) - Float(chitonNode.gridPosition.y))
                return (dx + dy) - 1 * min(dx, dy)
            }

            override func cost(to node: GKGraphNode) -> Float {
                Float(chitonCost)
            }
        }

        let width = matrix.columns.count
        let height = matrix.rows.count
        let graph = GKGridGraph(
            fromGridStartingAt: vector_int2(x: 0, y: 0),
            width: Int32(width),
            height: Int32(height),
            diagonalsAllowed: false,
            nodeClass: ChitonNode.self
        )

        matrix.forEachPosition { node, position in
            guard let chitonNode = graph.node(
                atGridPosition: vector_int2(
                    x: Int32(position.x),
                    y: Int32(position.y)
                )
            ) as? ChitonNode else { return }

            chitonNode.chitonCost = node
        }

        let startingNode = graph.node(atGridPosition: vector_int2(
            x: 0,
            y: 0
        ))!
        let endingNode = graph.node(atGridPosition: vector_int2(
            x: Int32(width - 1),
            y: Int32(height - 1)
        ))!

        return graph.findPath(from: startingNode, to: endingNode)
            .compactMap { $0 as? ChitonNode }
            .dropFirst()
            .map(\.chitonCost)
            .reduce(0, +)
    }

    public static func solvePartOne(from input: String) -> Int {
        let xs = Matrix(input.lines.map { line in
            line.compactMap {
                Int(String($0))
            }
        })

        return findCost(for: xs)
    }

    public static func solvePartTwo(from input: String) -> Int {
        let vals = input.lines.map { line in
            line.compactMap {
                Int(String($0))
            }
        }

        func increment(_ value: Int, by amount: Int) -> Int {
            let new = value + amount
            return new > 9
                ? new % 10 + 1
                : new
        }

        let expanded = (0..<5).flatMap { inc in
            vals.map { row in
                row.map { increment($0, by: inc) }
            }
        }
            .map { row in
                (0..<5).flatMap { inc in
                    row.map { increment($0, by: inc) }
                }
            }

        let xs = Matrix(expanded)
        return findCost(for: xs)
    }
}

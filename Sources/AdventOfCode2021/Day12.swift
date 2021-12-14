import Collections

public enum Day12 {

    struct Cave: Identifiable, Hashable {
        enum Kind {
            case big
            case small
        }

        let id: String
        let kind: Kind

        init(_ rawValue: String) {
            self.id = rawValue
            self.kind = rawValue.allSatisfy(\.isLowercase) ? .small : .big
        }
    }

    enum Node: Identifiable, Hashable {
        case start
        case cave(Cave)
        case end

        var id: String {
            switch self {
            case .start: return "start"
            case .end: return "end"
            case .cave(let cave): return cave.id
            }
        }

        init(_ rawValue: String) {
            switch rawValue {
            case "start":
                self = .start
            case "end":
                self = .end
            default:
                self = .cave(.init(rawValue))
            }
        }
    }

    struct Edge: Identifiable, Hashable {
        let startNode: Node
        let endNode: Node
        let id: String

        init(_ rawValue: String) {
            self.id = rawValue
            let parts = rawValue.split(separator: "-")
            let first = String(parts.first!)
            let last = String(parts.last!)
            startNode = .init(first)
            endNode = .init(last)
        }

        var canRevisit: Bool {
            switch (startNode, endNode) {
            case (.start, _),
                 (_, .start),
                 (.end, _),
                 (_, .end):
                return false
            case (.cave(let cave), _), (_, .cave(let cave)):
                return cave.kind == .big
            }
        }
    }

    public static func solvePartOne(from input: String) -> Int {
        let edges = input.lines.map(Edge.init)
        let graph: [Node: Set<Node>] = {
            var dict = [Node: [Node]]()
            for edge in edges {
                dict[edge.startNode] = dict[edge.startNode, default: []] + [edge.endNode]
                dict[edge.endNode] = dict[edge.endNode, default: []] + [edge.startNode]
            }
            return dict.mapValues(Set.init)
        }()

        func paths(
            from startingNode: Node,
            to endingNode: Node,
            visited: OrderedSet<Node>? = nil
        ) -> [[Node]] {
            var mutableVisited: OrderedSet<Node>
            if let visited = visited {
                mutableVisited = visited
            } else {
                mutableVisited = OrderedSet<Node>()
            }
            mutableVisited.append(startingNode)

            if startingNode == endingNode {
                return [Array(mutableVisited)]
            }

            let unvistable = mutableVisited.filter {
                if case let .cave(cave) = $0 {
                    return cave.kind != .big
                }

                return true
            }

            guard let neighbors = graph[startingNode]?.subtracting(unvistable) else {
                return []
            }

            return neighbors.flatMap { neighbor in
                paths(from: neighbor, to: endingNode, visited: mutableVisited)
            }
        }

        return paths(from: .start, to: .end).count
    }

    public static func solvePartTwo(from input: String) -> Int {
        let edges = input.lines.map(Edge.init)
        let graph: [Node: Set<Node>] = {
            var dict = [Node: [Node]]()
            for edge in edges {
                dict[edge.startNode] = dict[edge.startNode, default: []] + [edge.endNode]
                dict[edge.endNode] = dict[edge.endNode, default: []] + [edge.startNode]
            }
            return dict.mapValues(Set.init)
        }()

        func paths(
            from startingNode: Node,
            to endingNode: Node,
            visited: [Node]? = nil,
            doubleVisitSmallNode: Node? = nil
        ) -> [[Node]] {
            var mutableVisited: [Node]
            if let visited = visited {
                mutableVisited = visited
            } else {
                mutableVisited = []
            }

            mutableVisited.append(startingNode)

            if startingNode == endingNode {
                return [mutableVisited]
            }

            let unvistable = mutableVisited.filter {
                if case let .cave(cave) = $0 {
                    switch cave.kind {
                    case .big:
                        return false
                    case .small:
                        if $0 == doubleVisitSmallNode {
                            return mutableVisited.filter { $0 == doubleVisitSmallNode }.count == 2
                        }

                        return true
                    }
                }

                return true
            }

            guard let neighbors = graph[startingNode]?.subtracting(unvistable) else {
                return []
            }

            return neighbors.flatMap { neighbor in
                paths(
                    from: neighbor,
                    to: endingNode,
                    visited: mutableVisited,
                    doubleVisitSmallNode: doubleVisitSmallNode
                )
            }
        }

        let allPaths = paths(from: .start, to: .end)
            + graph.keys.filter {
                switch $0 {
                case .cave(let cave):
                    return cave.kind == .small
                default:
                    return false
                }
            }.flatMap {
                paths(from: .start, to: .end, doubleVisitSmallNode: $0)
            }

        return Set(allPaths).count
    }
}

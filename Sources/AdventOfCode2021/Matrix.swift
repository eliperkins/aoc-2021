struct Matrix<T> {
    private let storage: [[T]]

    init(_ xs: [[T]]) {
        storage = xs
    }

    var rows: [[T]] {
        storage
    }

    var columns: [[T]] {
        storage[0].indices.map { index in
            storage.map { $0[index] }
        }
    }

    func atPosition(x: Int, y: Int) -> T? {
        if storage.indices.contains(y) {
            let row = storage[y]
            if row.indices.contains(x) {
                return row[x]
            }
        }

        return nil
    }

    func forEachPosition(_ fn: (T, (x: Int, y: Int)) -> Void) {
        rows.enumerated().forEach { (rowIndex, row) in
            row.enumerated().forEach { (columnIndex, item) in
                fn(item, (x: columnIndex, y: rowIndex))
            }
        }
    }

    func collect(_ predicate: (T, (x: Int, y: Int)) -> Bool) -> [T] {
        var output = [T]()
        rows.enumerated().forEach { (rowIndex, row) in
            row.enumerated().forEach { (columnIndex, item) in
                if predicate(item, (x: columnIndex, y: rowIndex)) {
                    output.append(item)
                }
            }
        }
        return output
    }

    func collectLocations(_ predicate: (T, (x: Int, y: Int)) -> Bool) -> [(T, (x: Int, y: Int))] {
        var output = [(T, (x: Int, y: Int))]()
        rows.enumerated().forEach { (rowIndex, row) in
            row.enumerated().forEach { (columnIndex, item) in
                if predicate(item, (x: columnIndex, y: rowIndex)) {
                    output.append((item, (x: columnIndex, y: rowIndex)))
                }
            }
        }
        return output
    }
}

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
}

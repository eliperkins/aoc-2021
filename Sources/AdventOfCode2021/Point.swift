struct Point: Hashable {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(_ coordinates: (Int, Int)) {
        self.x = coordinates.0
        self.y = coordinates.1
    }

    var adjecent: [Point] {
        [
            Point(x: x + 1, y: y),
            Point(x: x + 1, y: y + 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x - 1, y: y),
            Point(x: x - 1, y: y + 1),
            Point(x: x - 1, y: y - 1),
            Point(x: x, y: y + 1),
            Point(x: x, y: y - 1)
        ]
    }
}

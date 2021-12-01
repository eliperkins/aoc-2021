import Foundation

extension String {
    var lines: [String] {
        var lines = [String]()
        enumerateLines { (line, _) in
            lines.append(line)
        }
        return lines
    }
}

import Algorithms

public enum Day16 {
    struct Packet {
        enum PacketType {
            enum OperationType: Int {
                case sum = 0
                case product = 1
                case minimum = 2
                case maximum = 3
                case literal = 4
                case greaterThan = 5
                case lessThan = 6
                case equalTo = 7
            }

            case literal(Int)
            case operation(type: OperationType, subpackets: [Packet])
        }

        let version: Int
        let type: PacketType
    }

    static func versionTotal(for packet: Packet) -> Int {
        switch packet.type {
        case .literal:
            return packet.version
        case .operation(_, let subpackets):
            return packet.version + subpackets.reduce(0) { acc, next in
                acc + versionTotal(for: next)
            }
        }
    }

    static func packetFromHex(_ hexValue: String) -> (Packet, String?) {
        let binary = hexValue.map { val -> String in
            let binaryString = String(val).toBinary()
            return binaryString.leftPad(with: "0", minLength: 4)
        }
            .joined()
        return packetFromBinary(binary)
    }

    // swiftlint:disable:next cyclomatic_complexity function_body_length
    static func packetFromBinary(_ binary: String) -> (Packet, String?) {
        let version = binary.prefix(3).compactMap { String($0) }.joined().fromBinary()
        let idValue = binary.dropFirst(3)
            .prefix(3)
            .compactMap { String($0) }
            .joined()
            .fromBinary()
        let id = Packet.PacketType.OperationType(rawValue: idValue)!
        let remaining = binary.dropFirst(6)
        switch id {
        case .literal:
            var value = ""
            var iter = remaining
            var next = remaining.prefix(5)
            while next.count == 5 {
                iter = iter.dropFirst(5)
                let leading = next.popFirst()
                value += next

                switch leading {
                case "0":
                    return (Packet(version: version, type: .literal(value.fromBinary())), String(iter))
                default:
                    next = iter.prefix(5)
                }
            }
        default:
            switch remaining.prefix(1) {
            case "0":
                let length = String(remaining.dropFirst(1).prefix(15)).fromBinary()
                var bits = String(remaining.dropFirst(16).prefix(length))
                var packets = [Packet]()
                while !bits.isEmpty && !bits.allSatisfy({ $0 == "0" }) {
                    let (packet, remainder) = packetFromBinary(bits)
                    packets.append(packet)
                    if let remainder = remainder {
                        bits = remainder
                    }
                }
                return (
                    Packet(version: version, type: .operation(type: id, subpackets: packets)),
                    String(remaining.dropFirst(16 + length))
                )
            case "1":
                let subpacketCount = String(remaining.dropFirst(1).prefix(11)).fromBinary()
                var bits = String(remaining.dropFirst(12))
                var subpackets = [Packet]()
                while subpackets.count < subpacketCount {
                    let (packet, remainder) = packetFromBinary(bits)
                    subpackets.append(packet)
                    if let remainder = remainder {
                        bits = remainder
                    }
                }
                return (
                    Packet(version: version, type: .operation(type: id, subpackets: subpackets)),
                    bits
                )
            default:
                fatalError()
            }
        }

        fatalError()
    }

    public static func solvePartOne(from input: String) -> Int {
        let (packet, _) = packetFromHex(input)
        return versionTotal(for: packet)
    }

    // swiftlint:disable:next cyclomatic_complexity
    static func evaluate(_ packet: Packet) -> Int {
        let collected: [Int] = {
            var ints = [Int]()
            switch packet.type {
            case .literal(let value):
                ints.append(value)
            case .operation(_, let subpackets):
                ints.append(contentsOf: subpackets.map(evaluate))
            }
            return ints
        }()
        switch packet.type {
        case .literal(let value):
            return value
        case .operation(let type, _):
            switch type {
            case .sum:
                return collected.reduce(0, +)
            case .product:
                return collected.reduce(1, *)
            case .minimum:
                return collected.min() ?? 0
            case .maximum:
                return collected.max() ?? 0
            case .literal:
                fatalError()
            case .greaterThan:
                assert(collected.count == 2)
                return collected.first! > collected.last! ? 1 : 0
            case .lessThan:
                assert(collected.count == 2)
                return collected.first! < collected.last! ? 1 : 0
            case .equalTo:
                assert(collected.count == 2)
                return collected.first! == collected.last! ? 1 : 0
            }
        }
    }

    public static func solvePartTwo(from input: String) -> Int {
        let (packet, _) = packetFromHex(input)
        return evaluate(packet)
    }
}

extension String {
    func toBinary() -> String {
        String(Int(self, radix: 16)!, radix: 2)
    }

    func fromBinary() -> Int {
        Int(self, radix: 2)!
    }

    func leftPad(with padding: String, minLength: Int) -> String {
        let array = Array(repeating: padding, count: minLength - count) + [self]
        return array.joined()
    }
}

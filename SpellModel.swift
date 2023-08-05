import Foundation

enum CodingKeys: String, CodingKey {
    case name
    case level
    case school
    case time
    case range
    case components = "m"
    case componentsM = "m.material"
    case componentsS = "m.string"
    case duration
    case description
}

struct Spell: Codable, Identifiable {
    let name: String
    let level: Level
    let school: String
    let time: [TimeItem]
    let range: [RangeItem]
    let components: Components?
    let duration: [DurationItem]
    let description: [DescriptionItem]

    var id: String { name }
}

enum Level: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
    var displayValue: String {
        switch self {
        case .int(let intValue):
            return String(intValue)
        case .string(let stringValue):
            return stringValue
        }
    }
}


struct Components: Codable {
    let v: Bool?
    let s: Bool?
    let m: Material?
    let r: Bool?
}

enum Material: Codable {
    case materialClass(MaterialClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(MaterialClass.self) {
            self = .materialClass(x)
        } else if let x = try? container.decode(String.self) {
            self = .string(x)
        } else {
            throw DecodingError.typeMismatch(Material.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Material"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .materialClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct MaterialClass: Codable {
    let text: String?
    let cost: Int?
    let consume: ConsumeType?
}


enum ConsumeType: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ConsumeType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Mismatched Types"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum TimeItem: Codable, Hashable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}

enum RangeItem: Codable, Hashable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}

enum DurationItem: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}

enum DescriptionItem: Codable, Hashable {
    case string(String)
    case object(DescriptionObject)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else {
            let obj = try container.decode(DescriptionObject.self)
            self = .object(obj)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str):
            try container.encode(str)
        case .object(let obj):
            try container.encode(obj)
        }
    }
}

struct DescriptionObject: Codable, Hashable {
    let type: String
    let entries: [DescriptionItem]?
    let name: String?
    let items: [DescriptionItem]?
}

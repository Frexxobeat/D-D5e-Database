import SwiftUI
import Foundation

struct DNDClass: Codable {
    var className: String?
    var classFeature: [Feature]?
    var subclass: [Subclass]?
    var spellcasting: Spellcasting?
    var spellProgression: [[Int]]?

    private enum CodingKeys: String, CodingKey {
        case spellcasting
    }

    mutating func setClassName(name: String) {
        self.className = name
    }

    mutating func setSpellProgression(progression: [[Int]]) {
        self.spellProgression = progression
    }
}

struct Spellcasting: Codable {
    var info: [SpellcastingInfo]
}

struct SpellcastingInfo: Codable {
    var name: String?
    var desc: [String]?
}

struct Subclass: Codable {
    let name: String
    let subclassFeature: [Feature]?
}

struct Feature: Codable, Identifiable {
    var id: String { name }
    let name: String
    let source: String
    let page: Int
    let level: Int
    let header: Int?
    let entries: [EntryContent]
}

enum EntryContent: Codable {
    case string(String)
    case object([String: AnyCodable])

    init(from decoder: Decoder) throws {
        if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        if let dictValue = try? decoder.singleValueContainer().decode([String: AnyCodable].self) {
            self = .object(dictValue)
            return
        }
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Mismatched Types"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .object(let object):
            try container.encode(object)
        }
    }
}

struct AnyCodable: Codable {
    private var value: Any

    init<T>(_ value: T?) {
        self.value = value ?? ()
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.init(())
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let array = try? container.decode([AnyCodable].self) {
            self.init(array.map { $0.value })
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            self.init(dictionary.mapValues { $0.value })
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyCodable")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case let bool as Bool:
            try container.encode(bool)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let array as [Any]:
            try container.encode(array.map { AnyCodable($0) })
        case let dict as [String: Any]:
            try container.encode(dict.mapValues { AnyCodable($0) })
        default:
            let context = EncodingError.Context(codingPath: [], debugDescription: "Unsupported type!")
            throw EncodingError.invalidValue(value, context)
        }
    }
}





func loadDNDClasses() -> [String: DNDClass]? {
    guard let url = Bundle.main.url(forResource: "cleaned_combined_classes_v2", withExtension: "json") else { return nil }

    do {
        let data = try Data(contentsOf: url)
        var decodedData = try JSONDecoder().decode([String: DNDClass].self, from: data)
        
        // Populate className property and spell progression
        for (key, _) in decodedData {
            decodedData[key]?.setClassName(name: key)
            if let progression = SpellProgressionData.progressions[key] {
                decodedData[key]?.setSpellProgression(progression: progression)
            }
        }
        
        return decodedData
    } catch {
        print("Error decoding data: \(error)")
        if let decodingError = error as? DecodingError {
            print("DecodingError: \(decodingError)")
        }
        return nil // Ensure that the function returns a value even in the case of an error
    }
}

// Test the function
let classes = loadDNDClasses()

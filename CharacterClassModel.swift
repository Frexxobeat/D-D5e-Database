//
//
//import Foundation
//import SwiftUI
//
//
//enum ClassType: String, Codable, Hashable, CaseIterable {
//    case fighter = "Fighter", barbarian = "Barbarian", bard = "Bard", cleric = "Cleric", druid = "Druid",
//         artificer = "Artificer", monk = "Monk", paladin = "Paladin", ranger = "Ranger", rogue = "Rogue",
//         sorcerer = "Sorcerer", warlock = "Warlock", wizard = "Wizard", runescribe = "Rune-Scribe",
//         mystic = "Mystic", illrigger = "Illrigger"
//}
//
//
//
//
//
//
//
//
//// MARK: - Main Item Structure
//struct Item: Codable, Hashable {
//    let classes: [DnDClass]
//    let subclasses: [Subclass]
//    let classFeatures: [ClassFeature]
//    let subclassFeatures: [SubclassFeature]
//}
//
//// MARK: - DnDClass
//struct DnDClass: Codable, Hashable {
//    let name, source: String
//    let page: Int
//    let srd: Bool?
//    let hd: HD
//    let proficiency: [String]?
//    let startingProficiencies: StartingProficiencies
//    let startingEquipment: StartingEquipment
//    let multiclassing: Multiclassing
//    let classFeatures: [ClassFeatureReference]
//    let subclassTitle: String
//    let fluff: [Fluff]
//    let optionalFeatureProgression: [FeatureProgression]
//}
//
//struct HD: Codable, Hashable {
//    let number, faces: Int
//}
//
//struct StartingProficiencies: Codable, Hashable {
//    let armor, weapons: [String]
//    let skills: [Skill]
//    let tools: [String]?
//}
//
//struct Skill: Codable, Hashable {
//    let choose: Choose
//}
//
//struct Choose: Codable, Hashable {
//    let type: String
//    let from: [String]
//    let count: Int
//}
//
//struct StartingEquipment: Codable, Hashable {
//    let additionalFromBackground: Bool
//    let startingEquipmentDefault: [String]
//    let goldAlternative: String
//    let defaultData: [DefaultDatum]
//}
//
//struct DefaultDatum: Codable, Hashable {
//    let a: [EquipmentElement]
//    let b: [EquipmentElement]
//}
//
//struct EquipmentElement: Codable, Hashable {
//    let equipmentType: String?
//    let quantity: Int?
//    let item: String?
//}
//
//struct Multiclassing: Codable, Hashable {
//    let requirements: Requirements
//    let proficienciesGained: ProficienciesGained
//}
//
//struct Requirements: Codable, Hashable {
//    let or: [AttributeRequirement]
//}
//
//struct AttributeRequirement: Codable, Hashable {
//    let str, dex: Int?
//}
//
//struct ProficienciesGained: Codable, Hashable {
//    let armor, weapons: [String]
//}
//
//struct ClassFeatureReference: Codable, Hashable {
//    let classFeature: String
//    let gainSubclassFeature: Bool
//}
//
//struct Fluff: Codable, Hashable {
//    let name: String?
//    let type: String
//    let entries: [Entry]
//}
//
//struct FeatureProgression: Codable, Hashable {
//    let name: String
//    let featureType: [String]
//    let progression: [String: Int]
//}
//
//// MARK: - Subclass
//struct Subclass: Codable, Hashable {
//    let name, subclassFlavor, source: String
//    let page: Int
//    let className: String
//    let features: [SubclassFeatureReference]
//    let fluff: [Fluff]?
//    let subclassTableGroups: [SubclassTableGroup]
//}
//
//struct SubclassTableGroup: Codable, Hashable {
//    let caption: String?
//    let colLabels: [String]?
//    let colStyles: [String]?
//    let rows: [[Entry]]
//}
//
//struct SubclassFeatureReference: Codable, Hashable {
//    let name: String
//    let level: Int
//}
//
//// MARK: - ClassFeature
//struct ClassFeature: Codable, Hashable {
//    let name, source: String
//    let page: Int
//    let className: String
//    let level: Int
//    let entries: [Entry]
//    let featureType: [String]?
//}
//
//// MARK: - SubclassFeature
//struct SubclassFeature: Codable, Hashable {
//    let name, source: String
//    let page: Int
//    let className, subclass: String
//    let level: Int
//    let entries: [Entry]
//    let gainSubclassFeature: Bool?
//}
//
//// MARK: - Entry
//enum Entry: Codable, Hashable {
//    case string(String)
//    case entryObject(EntryObject)
//    case entryList([String])
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let str = try? container.decode(String.self) {
//            self = .string(str)
//            return
//        }
//        if let obj = try? container.decode(EntryObject.self) {
//            self = .entryObject(obj)
//            return
//        }
//        if let list = try? container.decode([String].self) {
//            self = .entryList(list)
//            return
//        }
//        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched types in Entry")
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .string(let str):
//            try container.encode(str)
//        case .entryObject(let obj):
//            try container.encode(obj)
//        case .entryList(let list):
//            try container.encode(list)
//        }
//    }
//}
//
//struct EntryObject: Codable, Hashable {
//    let type: String
//    let name: String?
//    let entries: [Entry]
//}

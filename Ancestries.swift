// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct RacesData: Codable {
    let race: [Race]
}


// MARK: - Races
struct Races: Codable {
  
    let race: [Race]
    let subrace: [Subrace]?


    enum CodingKeys: String, CodingKey {
        case race, subrace
      
    }
}


// MARK: - Race
struct Race: Codable, Hashable {
    static func == (lhs: Race, rhs: Race) -> Bool {
            return lhs.name == rhs.name && lhs.source == rhs.source && lhs.page == rhs.page
    }
    
    let name, source: String
    let page: Int?
    let size: [Size]?
    let speed: RaceSpeed?
    let ability: [AbilityClass]?
    let traitTags: [String]?
    let languageProficiencies: [RaceLanguageProficiency]?
    var entries: [RaceEntry]?
    let otherSources: [Source]?
    let reprintedAs: [String]?
    let age: Age?
    let soundClip: SoundClip?
    let hasFluff, hasFluffImages: Bool?
    let lineage: LineageUnion?
    let additionalSpells: [RaceAdditionalSpell]?
    let darkvision: Int?
    let resist: [ResistElement]?
    let versions: [RaceVersion]?
    let heightAndWeight: HeightAndWeight?
    let skillProficiencies: [RaceSkillProficiency]?
    let creatureTypes: [CreatureTypeElement]?
    let creatureTypeTags: [String]?
    let toolProficiencies: [RaceToolProficiency]?
    let conditionImmune: [ConditionImmune]?
    let copy: RaceCopy?
    let feats: [Feat]?
    let srd, basicRules: Bool?
    let weaponProficiencies: [WeaponProficiency]?
    let additionalSources: [Source]?
    let blindsight: Int?
    let immune: [Immune]?
    let armorProficiencies: [RaceArmorProficiency]?
    let vulnerable: [String]?
    
    
 
    
 
    enum CodingKeys: String, CodingKey {
        case name, source, page, size, speed, ability, traitTags, languageProficiencies, entries, otherSources, reprintedAs, age, soundClip, hasFluff, hasFluffImages, lineage, additionalSpells, darkvision, resist
        case versions = "_versions"
        case heightAndWeight, skillProficiencies, creatureTypes, creatureTypeTags, toolProficiencies, conditionImmune
        case copy = "_copy"
        case feats, srd, basicRules, weaponProficiencies, additionalSources, blindsight, immune, armorProficiencies, vulnerable
    }
}



// MARK: - AbilityClass
struct AbilityClass: Codable , Hashable {
    let dex, wis, cha: Int?
    let choose: AbilityChooseClass?
    let str, int, con: Int?
}

// MARK: - AbilityChooseClass
struct AbilityChooseClass: Codable , Hashable {
    let from: [FromElement]
    let count, amount: Int?
}

enum FromElement: String, Codable , Hashable {
    case cha = "cha"
    case con = "con"
    case dex = "dex"
    case int = "int"
    case str = "str"
    case wis = "wis"
}

// MARK: - Source
struct Source: Codable , Hashable {
    let source: AdditionalSourceSource
    let page: Int?
}

enum AdditionalSourceSource: String, Codable , Hashable {
    case eepc = "EEPC"
    case egw = "EGW"
    case idRotF = "IDRotF"
    case scag = "SCAG"
    case uawge = "UAWGE"
}

// MARK: - RaceAdditionalSpell
struct RaceAdditionalSpell: Codable , Hashable {
    let innate: [String: RaceTentacledInnate]?
    let ability: AbilityUnion?
    let known: RacePurpleKnown?
}

enum AbilityUnion: Codable , Hashable {
    case creatureType(CreatureType)
    case enumeration(FromElement)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(FromElement.self) {
            self = .enumeration(x)
            return
        }
        if let x = try? container.decode(CreatureType.self) {
            self = .creatureType(x)
            return
        }
        throw DecodingError.typeMismatch(AbilityUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AbilityUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .creatureType(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

// MARK: - CreatureType
struct CreatureType: Codable , Hashable {
    let choose: [CreatureTypeChoose]
}

enum CreatureTypeChoose: String, Codable , Hashable {
    case cha = "cha"
    case construct = "construct"
    case int = "int"
    case undead = "undead"
    case wis = "wis"
}

enum RaceTentacledInnate: Codable , Hashable {
    case purpleInnate(RacePurpleInnate)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(RacePurpleInnate.self) {
            self = .purpleInnate(x)
            return
        }
        throw DecodingError.typeMismatch(RaceTentacledInnate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceTentacledInnate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .purpleInnate(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RacePurpleInnate
struct RacePurpleInnate: Codable , Hashable {
    let daily: Daily
}

// MARK: - Daily
struct Daily: Codable , Hashable {
    let the1: [String]

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

// MARK: - RacePurpleKnown
struct RacePurpleKnown: Codable , Hashable {
    let the1: Tentacled1?
    let empty: [Known]?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
        case empty = "_"
    }
}

// MARK: - Known
struct Known: Codable , Hashable {
    let choose: String
    let count: Int
}

enum Tentacled1: Codable , Hashable {
    case purple1(Purple1)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(Purple1.self) {
            self = .purple1(x)
            return
        }
        throw DecodingError.typeMismatch(Tentacled1.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Tentacled1"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .purple1(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Purple1
struct Purple1: Codable , Hashable {
    let rest: Daily?
    let ritual: [String]?
}

// MARK: - Age
struct Age: Codable , Hashable {
    let mature: Int?
    let max: Int
}

// MARK: - RaceArmorProficiency
struct RaceArmorProficiency: Codable , Hashable {
    let light: Bool
}

enum ConditionImmune: String, Codable , Hashable {
    case disease = "disease"
    case exhaustion = "exhaustion"
    case poisoned = "poisoned"
}

// MARK: - RaceCopy
struct RaceCopy: Codable , Hashable {
    let name, source: String
    let mod: RaceCopyMod
    let preserve: RacePreserve?

    enum CodingKeys: String, CodingKey {
        case name, source
        case mod = "_mod"
        case preserve = "_preserve"
    }
}

// MARK: - RaceCopyMod
struct RaceCopyMod: Codable , Hashable {
    let entries: Entries
}

enum Entries: Codable , Hashable {
    case entr(Entr)
    case entrArray([Entr])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Entr].self) {
            self = .entrArray(x)
            return
        }
        if let x = try? container.decode(Entr.self) {
            self = .entr(x)
            return
        }
        throw DecodingError.typeMismatch(Entries.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Entries"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .entr(let x):
            try container.encode(x)
        case .entrArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Entr
struct Entr: Codable , Hashable {
    let mode: Mode
    let replace: String?
    let items: Items?
    let names: String?
}

// MARK: - Items
struct Items: Codable , Hashable {
    let name: String
    let type: ItemsType
    let entries: [String]
}

enum ItemsType: String, Codable , Hashable {
    case entries = "entries"
    case inset = "inset"
    case list = "list"
    case table = "table"
}

enum Mode: String, Codable , Hashable {
    case appendArr = "appendArr"
    case removeArr = "removeArr"
    case replaceArr = "replaceArr"
}

// MARK: - RacePreserve
struct RacePreserve: Codable , Hashable {
    let reprintedAs: Bool
}

enum CreatureTypeElement: Codable , Hashable {
    case creatureType(CreatureType)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(CreatureType.self) {
            self = .creatureType(x)
            return
        }
        throw DecodingError.typeMismatch(CreatureTypeElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CreatureTypeElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .creatureType(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum RaceEntry: Codable, Hashable, Identifiable {
    case purpleEntry(RacePurpleEntry)
    case string(String)
    
    var id: UUID {
        return UUID()
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RacePurpleEntry.self) {
            self = .purpleEntry(x)
            return
        }
        throw DecodingError.typeMismatch(RaceEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .purpleEntry(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    var displayText: String {
        switch self {
        case .string(let string):
            return string
        case .purpleEntry(let purpleEntry):
            return purpleEntry.name ?? ""
        }
    }
}

// MARK: - RacePurpleEntry
struct RacePurpleEntry: Codable , Hashable {
    let name: String?
    let entries: [RaceIndecentEntry]?
    let type: ItemsType
    let style: Style?
    let items: [RaceItemClass]?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable , Hashable {
    let overwrite: String
}

enum RaceIndecentEntry: Codable , Hashable {
    case fluffyEntry(RaceFluffyEntry)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RaceFluffyEntry.self) {
            self = .fluffyEntry(x)
            return
        }
        throw DecodingError.typeMismatch(RaceIndecentEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceIndecentEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffyEntry(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceFluffyEntry
struct RaceFluffyEntry: Codable , Hashable {
    let type: ItemsType
    let items: [RaceItemUnion]?
    let style: Style?
    let caption: String?
    let colLabels, colStyles: [String]?
    let rows: [[String]]?
    let name: String?
    let entries: [RaceHilariousEntry]?
}

enum RaceHilariousEntry: Codable , Hashable {
    case string(String)
    case tentacledEntry(RaceTentacledEntry)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RaceTentacledEntry.self) {
            self = .tentacledEntry(x)
            return
        }
        throw DecodingError.typeMismatch(RaceHilariousEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceHilariousEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .tentacledEntry(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceTentacledEntry
struct RaceTentacledEntry: Codable , Hashable {
    let type: ItemsType
    let style: String
    let items: [RaceItemClass]
}

// MARK: - RaceItemClass
struct RaceItemClass: Codable , Hashable {
    let type: ItemType
    let name: String
    let entry: String?
    let entries: [String]?
}

enum ItemType: String, Codable , Hashable {
    case item = "item"
    case itemSpell = "itemSpell"
}

enum RaceItemUnion: Codable , Hashable {
    case itemClass(RaceItemClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RaceItemClass.self) {
            self = .itemClass(x)
            return
        }
        throw DecodingError.typeMismatch(RaceItemUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceItemUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .itemClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Style: String, Codable , Hashable {
    case listHangNotitle = "list-hang-notitle"
}

// MARK: - Feat
struct Feat: Codable , Hashable {
    let any: Int
}

// MARK: - HeightAndWeight
struct HeightAndWeight: Codable , Hashable {
    let baseHeight: Int
    let heightMod: HeightMod
    let baseWeight: Int
    let weightMod: String?
}

enum HeightMod: String, Codable , Hashable {
    case the1D10 = "1d10"
    case the2D10 = "2d10"
    case the2D12 = "2d12"
    case the2D4 = "2d4"
    case the2D6 = "2d6"
    case the2D8 = "2d8"
}

enum Immune: String, Codable , Hashable {
    case acid = "acid"
    case cold = "cold"
    case fire = "fire"
    case lightning = "lightning"
    case necrotic = "necrotic"
    case poison = "poison"
}

// MARK: - RaceLanguageProficiency
struct RaceLanguageProficiency: Codable , Hashable {
    let auran, common, other, celestial: Bool?
    let anyStandard: Int?
    let goblin, sylvan, draconic, dwarvish: Bool?
    let elvish, giant, primordial, gnomish: Bool?
    let terran, undercommon, orc, halfling: Bool?
    let aquan: Bool?
    let choose: LanguageProficiencyChoose?
    let infernal, abyssal: Bool?
}

// MARK: - LanguageProficiencyChoose
struct LanguageProficiencyChoose: Codable , Hashable {
    let from: [String]
    let count: Int?
}

enum LineageUnion: Codable , Hashable {
    case bool(Bool)
    case enumeration(LineageEnum)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(LineageEnum.self) {
            self = .enumeration(x)
            return
        }
        throw DecodingError.typeMismatch(LineageUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LineageUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .enumeration(let x):
            try container.encode(x)
        }
    }
}

enum LineageEnum: String, Codable , Hashable {
    case ua1 = "UA1"
    case vrgr = "VRGR"
}

enum ResistElement: Codable , Hashable {
    case resistClass(ResistClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ResistClass.self) {
            self = .resistClass(x)
            return
        }
        throw DecodingError.typeMismatch(ResistElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ResistElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .resistClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ResistClass
struct ResistClass: Codable , Hashable {
    let choose: ResistChoose
}

// MARK: - ResistChoose
struct ResistChoose: Codable , Hashable {
    let from: [String]
}

enum Size: String, Codable , Hashable {
    case m = "M"
    case s = "S"
    case v = "V"
}

// MARK: - RaceSkillProficiency
struct RaceSkillProficiency: Codable , Hashable {
    let intimidation, perception, stealth: Bool?
    let choose: LanguageProficiencyChoose?
    let survival, deception: Bool?
    let any: Int?
    let athletics, acrobatics, performance, persuasion: Bool?
}

// MARK: - SoundClip
struct SoundClip: Codable , Hashable {
    let type: SoundClipType
    let path: String
}

enum SoundClipType: String, Codable , Hashable {
    case typeInternal = "internal"
}

enum RaceSpeed: Codable , Hashable {
    case integer(Int)
    case purpleSpeed(PurpleSpeed)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(PurpleSpeed.self) {
            self = .purpleSpeed(x)
            return
        }
        throw DecodingError.typeMismatch(RaceSpeed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceSpeed"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .purpleSpeed(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PurpleSpeed
struct PurpleSpeed: Codable , Hashable {
    let walk: Int
    let fly, swim, climb: Climb?
}

enum Climb: Codable , Hashable {
    case bool(Bool)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        throw DecodingError.typeMismatch(Climb.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Climb"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceToolProficiency
struct RaceToolProficiency: Codable , Hashable {
    let any: Int?
    let musicalInstrument: Bool?

    enum CodingKeys: String, CodingKey {
        case any
        case musicalInstrument = "musical instrument"
    }
}

// MARK: - RaceVersion
struct RaceVersion: Codable , Hashable {
    let name: String?
    let source: RacePurpleSource?
    let mod: VersionMod?
    let skillProficiencies, darkvision: JSONNull?
    let template: Template?
    let implementations: [PurpleImplementation]?
    let additionalSpells: JSONNull?

    enum CodingKeys: String, CodingKey {
        case name, source
        case mod = "_mod"
        case skillProficiencies, darkvision
        case template = "_template"
        case implementations = "_implementations"
        case additionalSpells
    }
}

// MARK: - PurpleImplementation
struct PurpleImplementation: Codable , Hashable {
    let variables: PurpleVariables
    let resist: [String]?

    enum CodingKeys: String, CodingKey {
        case variables = "_variables"
        case resist
    }
}

// MARK: - PurpleVariables
struct PurpleVariables: Codable , Hashable {
    let color, damageType: String
}

// MARK: - VersionMod
struct VersionMod: Codable , Hashable {
    let entries: Entr
}

enum RacePurpleSource: String, Codable , Hashable {
    case mpmm = "MPMM"
    case tce = "TCE"
    
}

// MARK: - Template
struct Template: Codable , Hashable {
    let name, source: String
    let mod: TemplateMod

    enum CodingKeys: String, CodingKey {
        case name, source
        case mod = "_mod"
    }
}

// MARK: - TemplateMod
struct TemplateMod: Codable , Hashable {
    let entries: [Entr]
}

// MARK: - WeaponProficiency
struct WeaponProficiency: Codable , Hashable {
    let battleaxePhb, handaxePhb, lightHammerPhb, warhammerPhb: Bool?
    let longswordPhb, shortswordPhb, shortbowPhb, longbowPhb: Bool?
    let firearms: Bool?
    let choose: WeaponProficiencyChoose?
    let spearPhb, javelinPhb: Bool?

    enum CodingKeys: String, CodingKey {
        case battleaxePhb = "battleaxe|phb"
        case handaxePhb = "handaxe|phb"
        case lightHammerPhb = "light hammer|phb"
        case warhammerPhb = "warhammer|phb"
        case longswordPhb = "longsword|phb"
        case shortswordPhb = "shortsword|phb"
        case shortbowPhb = "shortbow|phb"
        case longbowPhb = "longbow|phb"
        case firearms, choose
        case spearPhb = "spear|phb"
        case javelinPhb = "javelin|phb"
    }
}

// MARK: - WeaponProficiencyChoose
struct WeaponProficiencyChoose: Codable , Hashable {
    let fromFilter: String
    let count: Int
}

// MARK: - Subrace
struct Subrace: Codable , Hashable {
    let name: String?
    let source, raceName, raceSource: String
    let page: Int
    let ability: [AbilityClass]?
    let entries: [SubraceEntry]?
    let hasFluff, hasFluffImages: Bool?
    let skillProficiencies: [SubraceSkillProficiency]?
    let srd: Bool?
    let versions: [SubraceVersion]?
    let darkvision: Int?
    let resist: [Immune]?
    let overwrite: Overwrite?
    let otherSources: [Source]?
    let reprintedAs, traitTags: [String]?
    let languageProficiencies: [SubraceLanguageProficiency]?
    let additionalSpells: [SubraceAdditionalSpell]?
    let basicRules: Bool?
    let heightAndWeight: HeightAndWeight?
    let armorProficiencies: [SubraceArmorProficiency]?
    let speed: SubraceSpeed?
    let alias: [String]?
    let weaponProficiencies: [[String: Bool]]?
    let skillToolLanguageProficiencies: [SkillToolLanguageProficiency]?
    let age: Age?
    let soundClip: SoundClip?
    let toolProficiencies: [SubraceToolProficiency]?
    let feats: [Feat]?

    enum CodingKeys: String, CodingKey {
        case name, source, raceName, raceSource, page, ability, entries, hasFluff, hasFluffImages, skillProficiencies, srd
        case versions = "_versions"
        case darkvision, resist, overwrite, otherSources, reprintedAs, traitTags, languageProficiencies, additionalSpells, basicRules, heightAndWeight, armorProficiencies, speed, alias, weaponProficiencies, skillToolLanguageProficiencies, age, soundClip, toolProficiencies, feats
    }
}

// MARK: - SubraceAdditionalSpell
struct SubraceAdditionalSpell: Codable , Hashable {
    let innate: [String: StickyInnate]?
    let ability: AbilityUnion?
    let expanded: Expanded?
    let known: RaceFluffyKnown?
}

// MARK: - Expanded
struct Expanded: Codable , Hashable {
    let s1, s2, s3, s4: [String]
    let s5: [String]
}

enum StickyInnate: Codable , Hashable {
    case fluffyInnate(RaceFluffyInnate)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(RaceFluffyInnate.self) {
            self = .fluffyInnate(x)
            return
        }
        throw DecodingError.typeMismatch(StickyInnate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StickyInnate"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffyInnate(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceFluffyInnate
struct RaceFluffyInnate: Codable , Hashable {
    let daily, rest: Daily?
}

// MARK: - RaceFluffyKnown
struct RaceFluffyKnown: Codable , Hashable {
    let the1: Sticky1

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

enum Sticky1: Codable , Hashable {
    case fluffy1(Fluffy1)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(Fluffy1.self) {
            self = .fluffy1(x)
            return
        }
        throw DecodingError.typeMismatch(Sticky1.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Sticky1"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffy1(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Fluffy1
struct Fluffy1: Codable , Hashable {
    let rest: Daily?
    let empty: [The1__]?

    enum CodingKeys: String, CodingKey {
        case rest
        case empty = "_"
    }
}

// MARK: - The1__
struct The1__: Codable , Hashable {
    let skillChoice: SkillChoice
    
    enum CodingKeys: String, CodingKey {
        case skillChoice = "choose"
    }
}

enum SkillChoice: String, Codable , Hashable {
    case level0ClassBard = "level=0|class=Bard"
    case level0ClassDruid = "level=0|class=Druid"
    case level0ClassWizard = "level=0|class=Wizard"
}

// MARK: - SubraceArmorProficiency
struct SubraceArmorProficiency: Codable , Hashable {
    let light, medium: Bool
}

enum SubraceEntry: Codable , Hashable {
    case stickyEntry(RaceStickyEntry)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RaceStickyEntry.self) {
            self = .stickyEntry(x)
            return
        }
        throw DecodingError.typeMismatch(SubraceEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SubraceEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stickyEntry(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceStickyEntry
struct RaceStickyEntry: Codable , Hashable {
    let name: String
    let entries: [RaceAmbitiousEntry]
    let type: ItemsType
    let data: DataClass?
}

enum RaceAmbitiousEntry: Codable , Hashable {
    case indigoEntry(RaceIndigoEntry)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(RaceIndigoEntry.self) {
            self = .indigoEntry(x)
            return
        }
        throw DecodingError.typeMismatch(RaceAmbitiousEntry.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RaceAmbitiousEntry"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .indigoEntry(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RaceIndigoEntry
struct RaceIndigoEntry: Codable , Hashable {
    let type: ItemsType
    let caption: String?
    let colLabels, colStyles: [String]?
    let rows: [[String]]?
    let style: Style?
    let items: [RaceItemClass]?
    let name: String?
    let entries: [String]?
}

// MARK: - SubraceLanguageProficiency
struct SubraceLanguageProficiency: Codable , Hashable {
    let common, dwarvish, undercommon, auran: Bool?
    let sylvan, elvish: Bool?
    let anyStandard: Int?
    let aquan, gnomish, goblin, other: Bool?
    let abyssal: Bool?
}

// MARK: - Overwrite
struct Overwrite: Codable , Hashable {
    let ability, traitTags, languageProficiencies, skillProficiencies: Bool?
}

// MARK: - SubraceSkillProficiency
struct SubraceSkillProficiency: Codable , Hashable {
    let perception, animalHandling: Bool?
    let any: Int?
    let athletics, survival, intimidation, history: Bool?
    let nature, sleightOfHand, stealth, deception: Bool?
    let persuasion, acrobatics: Bool?

    enum CodingKeys: String, CodingKey {
        case perception
        case animalHandling = "animal handling"
        case any, athletics, survival, intimidation, history, nature
        case sleightOfHand = "sleight of hand"
        case stealth, deception, persuasion, acrobatics
    }
}

// MARK: - SkillToolLanguageProficiency
struct SkillToolLanguageProficiency: Codable , Hashable {
    let choose: [LanguageProficiencyChoose]
}

enum SubraceSpeed: Codable , Hashable {
    case fluffySpeed(FluffySpeed)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(FluffySpeed.self) {
            self = .fluffySpeed(x)
            return
        }
        throw DecodingError.typeMismatch(SubraceSpeed.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SubraceSpeed"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .fluffySpeed(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - FluffySpeed
struct FluffySpeed: Codable , Hashable {
    let walk: Int
    let fly: Int?
    let swim: Climb?
}

// MARK: - SubraceToolProficiency
struct SubraceToolProficiency: Codable , Hashable {
    let anyArtisans: Int
}

// MARK: - SubraceVersion
struct SubraceVersion: Codable , Hashable {
    let template: Template?
    let implementations: [FluffyImplementation]?
    let name: String?
    let source: AdditionalSourceSource?
    let mod: VersionMod?
    let speed: Int?
    let skillProficiencies, additionalSpells, weaponProficiencies: JSONNull?

    enum CodingKeys: String, CodingKey {
        case template = "_template"
        case implementations = "_implementations"
        case name, source
        case mod = "_mod"
        case speed, skillProficiencies, additionalSpells, weaponProficiencies
    }
}

// MARK: - FluffyImplementation
struct FluffyImplementation: Codable , Hashable {
    let variables: FluffyVariables
    let resist: [Immune]?

    enum CodingKeys: String, CodingKey {
        case variables = "_variables"
        case resist
    }
}

// MARK: - FluffyVariables
struct FluffyVariables: Codable , Hashable {
    let color: String
    let damageType: Immune
    let area: Area
    let savingThrow: SavingThrow
}

enum Area: String, Codable , Hashable {
    case the15FootCone = "15-foot cone"
    case the5FootWide30FootLongLine = "5-foot-wide, 30-foot-long line"
}

enum SavingThrow: String, Codable , Hashable {
    case constitution = "Constitution"
    case dexterity = "Dexterity"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable , Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        // Since all instances of JSONNull are identical, they have the same hash value.
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
extension SubraceEntry {
    var displayText: String {
        switch self {
        case .string(let string):
            return string
        case .stickyEntry(let stickyEntry):
            return stickyEntry.name
        }
    }
}

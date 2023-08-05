//
//  DnDItem.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 05/07/2023.
//

import Foundation

struct DnDItem: Codable {
   
    let name: String
    let equipment_category: String?
    let weapon_category: String?
    let armor_category: String?
    let gear_category: String?
    let tool_category: String?
    let vehicle_category: String?
    let weapon_range: String?
    let category_range: String?
    let cost: Cost?
    let damage: Damage?
    let range: Range?
    let throw_range: ThrowRange?
    let properties: [Property]?
    let two_handed_damage: TwoHandedDamage?
    let armor_class: ArmorClass?
    let str_minimum: Int?
    let stealth_disadvantage: Bool?
    let weight: Int?
    let desc: [String]?
    let contents: [Content]?
    
    struct Cost: Codable {
        let quantity: Int?
        let unit: String?
    }
    
    struct Damage: Codable {
        let damage_dice: String?
        let damage_type: DamageType?
        
        struct DamageType: Codable {
            let name: String?
        }
    }
    
    struct Range: Codable {
        let normal: Int?
        let long: Int?
    }
    
    struct ThrowRange: Codable {
        let normal: Int?
        let long: Int?
    }
    
    struct Property: Codable {
        let name: String?
        let desc: [String]?
    }
    
    struct TwoHandedDamage: Codable {
        let damage_dice: String?
        let damage_type: DamageType?
        
        struct DamageType: Codable {
            let name: String?
        }
    }
    
    struct ArmorClass: Codable {
        let base: Int?
        let dex_bonus: Bool?
        let max_bonus: Int?
    }
    
    struct Content: Codable {
        let item: ContentItem?
        let quantity: Int?
        
        struct ContentItem: Codable {
            let name: String?
        }
    }
}


func loadJSONData(filename: String) -> Data? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
        return nil
    }
    
    do {
        return try Data(contentsOf: fileURL)
    } catch {
        print("Error loading file: \(error)")
        return nil
    }
}

func decodeItems(from data: Data) -> [DnDItem] {
    let decoder = JSONDecoder()
    
    do {
        return try decoder.decode([DnDItem].self, from: data)
    } catch {
        print("Error decoding data: \(error)")
        return []
    }
}

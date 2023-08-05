//
//  StatModel.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/07/2023.
//

import Foundation

struct Stat: Identifiable, Equatable, Hashable {
    let id = UUID()
    let statName: String
    var value: Int
    var modifier: Int {
        return (value - 10) / 2
    }
}

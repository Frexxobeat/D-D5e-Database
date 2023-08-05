//
//  CharacterGridViewModel.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 25/07/2023.
//

import Foundation
import SwiftUI



class CharacterGridViewModel: ObservableObject {
    
    @EnvironmentObject var characterManager : CharacterManager
    @Published var isAddingCharacter = false
    @Published var isEditing = false
    @Published var numColumns = 1
    
    

    var gridColumns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 1, maximum: 3 )), count: numColumns)
    }

    func remove(at offsets: IndexSet) {
        characterManager.characters.remove(atOffsets: offsets)
    }

    func toggleEditing() {
        withAnimation {
            isEditing.toggle()
        }
    }
}

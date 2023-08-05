//
//  CharacterDetails.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 06/07/2023.
//

import Foundation
import SwiftUI



struct CharacterDetails: View {
    @EnvironmentObject var character: Character
    @Binding var isEditing: Bool
    @State private var isShowingRestSheet = false
    private var gridColumns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 300, maximum: 1200)), count: 1)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 12) {
              
                //  CharacterBasicInfo(isEditing: $isEditing)
                
                
                HPBlockView(character: character, isEditing: isEditing, isShowingRestSheet: $isShowingRestSheet)
                
                
                HStack(spacing: 4) {
                    StatRectangleView(title: "AC", value: "\(character.armorClass)")
                    StatRectangleView(title: "Initiative", value: "+0") // Placeholder value
                    StatRectangleView(title: "Speed", value: "\(character.speed)") // Placeholder value
                    StatRectangleView(title: "Prof. Bonus", value: "\(character.proficiencyMod)")
                }
                
                
                
          
                
                
                
                VStack(alignment: .leading) {
                    Text("Stats")
                        .font(.title)
                        .bold()
                    
                    ForEach(character.stats.indices, id: \.self) { index in
                        StatView(stat: $character.stats[index], isEditing: isEditing )
                    }
                }
                
                

                
            }
            
            Divider()
            
            
            // Display SkillSheet
            
            SkillsSheet(character: character, isEditing: $isEditing)
            Text("whtat teh fuk")
            List(character.stats) { stat in
                HStack {
                    Text(stat.statName)
                    Text("\(stat.modifier)")
                
                }
            }
        }
        .padding(.horizontal)
    }
}




struct StatRectangleView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.headline)
        }
        .foregroundColor(.accentColor)
        .padding(4)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 70)
        .background(Color.accentColor.opacity(0.3).gradient)
        .cornerRadius(10)
    }
}


struct SkillRectangleView: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text("\(value)")
                .font(.headline)
        }
        .foregroundColor(.accentColor)
        .padding(4)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 70)
        .background(Color.accentColor.opacity(0.3).gradient)
        .cornerRadius(10)
    }
}


struct HPBlockView: View {
    var character: Character
    var isEditing: Bool = false
    @Binding var isShowingRestSheet: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            HPView(viewModel: HPViewViewModel(character: character, isEditing: isEditing))
            HStack {
                RestedSheet(character: character, isShowingRestSheet: $isShowingRestSheet)
                DeathSavesView(character: character)
            }
        }
        .padding()
        .background(Color.gray.gradient.opacity(0.2))
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
    }
}




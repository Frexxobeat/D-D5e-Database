//
//  CharacterCardView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 18/07/2023.
//

import SwiftUI


struct CharacterCard: View {
    var character: Character
    
    var body: some View {
        
        ZStack {
          
            VStack(alignment: .leading, spacing: 0) {
                   if let imageData = character.characterImage {
                            Image(uiImage: imageData)
                                .resizable()
                                .scaledToFill()
                       
                                                             
                               
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                                               
                               
                               
                        }
                }
            .frame(maxWidth: 350, maxHeight: .infinity)
            .overlay(alignment: .bottomLeading) {
                    cardText(character: character)
                        .minimumScaleFactor(0.2)
                                        
                }
                
            
                
           
        }
        .cornerRadius(10)
        
        
        
            }
           
         
            
        }
  
    


struct cardText: View  {
    var character: Character
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                   
                    .lineLimit(1)
                
                HStack {
                    Text("Level \(character.level)")
                    Text("|")
                    Text(character.classType?.className ?? "Unknown")
                        .minimumScaleFactor(0.5)
                    Text("|")
                    Text("\(character.race?.name ?? "Unknown")")
                }
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.0)], startPoint: .bottom, endPoint: .top))
           
        }
    }
}

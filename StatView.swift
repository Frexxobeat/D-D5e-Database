//
//  StatView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 16/07/2023.
//

import SwiftUI


struct StatView: View {
    @Binding var stat: Stat
    var isEditing: Bool
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(stat.value)")
                            .font(.caption)
                            .opacity(0.4)
                        
                      
                        
                        Text(stat.statName)
                        if isEditing {
                            Stepper(value: $stat.value, in: 0...30) { Text("") }
                                .animation(.default, value: isEditing)
                                .onChange(of: stat.value) { _ in
                                    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
                                    impactFeedbackgenerator.impactOccurred()
                                }
                        }
                        Spacer()
                        
                     
                        
                        ZStack {
                            Image(systemName: getIconForStat(statName: stat.statName))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .opacity(0.5)
                                .blendMode(.colorBurn)
                                .foregroundColor(.gray)
                                .offset(x: 16, y: 20)
                            
                            Text("+ \(stat.modifier)")
                                .bold()

                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.accentColor.opacity(0.2),Color(#colorLiteral(red: 0.593244791, green: 0.1132753417, blue: 0.6327852607, alpha: 1)).opacity(0.4)] ,  startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(16)
               
                      
                    }
                
                }
      
            }
        
        }
    }

        func getGradientForStat(statName: String) -> Gradient {
            switch statName.lowercased() {
            case "strength": return Gradient(colors: [Color.red.opacity(0.3), Color.orange.opacity(0.6)])
            case "dexterity": return Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.6)])
            case "constitution": return Gradient(colors: [Color.purple.opacity(0.3), Color.pink.opacity(0.6)])
            case "intelligence": return Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.6)])
            case "wisdom": return Gradient(colors: [Color.orange.opacity(0.3), Color.yellow.opacity(0.6)])
            case "charisma": return Gradient(colors: [Color.pink.opacity(0.3), Color.red.opacity(0.6)])
            default: return Gradient(colors: [Color.gray, Color.gray])
            }
        }
        
        func getIconForStat(statName: String) -> String {
            switch statName.lowercased() {
            case "strength": return "arrowtriangle.up.circle.fill"
            case "dexterity": return "arrow.triangle.2.circlepath.circle.fill"
            case "constitution": return "heart.fill"
            case "intelligence": return "brain"
            case "wisdom": return "eye.circle.fill"
            case "charisma": return "speaker.wave.2.circle.fill"
            default: return "questionmark"
            }
        }


//
//  HPViewViewModel.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 24/07/2023.
//

import Foundation
import SwiftUI
import Combine

class HPViewViewModel: ObservableObject {
    
    @Published var isEditing: Bool
    @Published var character: Character
    @Published private var hpChange: Int = 0
    @Published private var showHpChange: Bool = false
    @Published private var timer: Timer? = nil
    @Published private var hideHpChangeCancellable: Cancellable?
    var color: Color = .accentColor
    
    init(character: Character, isEditing: Bool){
        self.character = character
        self.isEditing = isEditing
    }
    
    var decrementButton: some View {
        Image(systemName: "minus")
            .font(.largeTitle)
       
            .frame(width: 70, height: 70)
            .contentShape(Rectangle())
        
        
        
        
        
            .onTapGesture {
                self.modifyHP(by: -1)
            }
            .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                if pressing {
                    self.startTimer(with: -1)
                } else {
                    self.stopTimer()
                }
            }) { }
    }
    
    var incrementButton: some View {
        Image(systemName: "plus")
            .font(.largeTitle)
           
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                self.modifyHP(by: 1)
            }
            .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                if pressing {
                    self.startTimer(with: 1)
                } else {
                    self.stopTimer()
                }
            }) { }
    }
    
    var hpView: some View {
        VStack {
            if isEditing {
                Text("Max HP")
                    .font(.caption)
                    .opacity(0.5)
                
                Text("\(character.maxHP)")
                    .font(.largeTitle)
                    .bold()
            } else {
                Text("Max HP: \(character.maxHP)")
                    .font(.caption)
                    .opacity(0.3)
                
                Text("\(character.currentHP)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
          
            }
            
            if showHpChange {
                Text("\(hpChange >= 0 ? "+" : "")\(hpChange)")
                    .font(.caption)
                
                    .transition(.opacity)
            }
        }
        .foregroundColor(color)
    }
        
    
    
    func startTimer(with value: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.modifyHP(by: value)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        // Start a timer to remove the hpChange view after 3 seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showHpChange = false
            }
            self.hpChange = 0
        }
    }
    
    func modifyHP(by value: Int) {
        if isEditing {
            character.maxHP = max(character.maxHP + value, 0)
        } else {
            character.currentHP = min(max(character.currentHP + value, 0), character.maxHP)
            hpChange += value
            withAnimation {
                showHpChange = true
            }
        }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

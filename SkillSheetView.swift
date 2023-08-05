import SwiftUI
struct SkillsSheet: View {
    @ObservedObject var character: Character
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Skills")
                .font(.largeTitle.bold())
            
            // Define a two-column grid
            let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(character.skills) { skill in
                    SkillRow(character: character, skill: skill, isEditing: $isEditing)
                    
                }
            }
        }
    }
}
struct SkillRow: View {
    @ObservedObject var character: Character
    @ObservedObject var skill: CharacterSkill
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            
            Text(skill.skillName)
            Spacer()
            Text("\(skill.modifierSign)\(skill.modifier)")
           
                Button(action: {
                    if isEditing {   skill.isProficient.toggle()
                    }
                }, label: {
                    Image(systemName: skill.isProficient ? "circle.fill" : "circle")
                })
            
        }
    

        
        
        .padding()
        .background(
            LinearGradient(
                colors: [Color.accentColor.opacity(0.2), Color(#colorLiteral(red: 0.593244791, green: 0.1132753417, blue: 0.6327852607, alpha: 1)).opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .onAppear {
            
        }
    }
}

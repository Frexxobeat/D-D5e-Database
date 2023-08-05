//
//  SkillView.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 03/06/2023.
//

import SwiftUI

struct SkillView: View {
    
    @EnvironmentObject var character: Character
    
    var body: some View {
        HStack {
            Text("\(character.skillArray.index(after: 0))")
            Spacer()
            Text("modifier")
        }.padding(5)
        
           

    }
}

struct SkillView_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}

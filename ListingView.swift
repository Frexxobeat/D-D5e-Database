//
//  CharacterList.swift
//  CharacterCompanion
//
//  Created by Frederik Rex on 03/06/2023.
//

import Foundation
import SwiftUI

struct Listing: View {
    

    @EnvironmentObject var data : CharacterManager
    

    var body: some View {
        VStack {
            List{
                ForEach(data){
                    character in
                    HStack {
                        Text(character.name)
                        Spacer()
                        Text(character.classType)
                    }
                }
                
              
            }
            Text("characters")
            
        } .environmentObject(Character())
        
    }
        
}
struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        Listing()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environmentObject(Character)
    }
}


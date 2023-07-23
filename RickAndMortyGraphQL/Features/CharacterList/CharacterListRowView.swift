//
//  CharacterListRowView.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import SwiftUI

struct CharacterListRowView: View {
    
    let character: CharacterSmall
    
    var body: some View {
            
        VStack(alignment: .leading) {
            Text(character.name ?? "Loading...")
                .font(.title3)
                .foregroundColor(.accentColor)
                .redacted(reason: character.name == nil ? .placeholder : [])
            Text("\(character.episode.count) episode(s)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
    

struct CharacterListRowView_Previews: PreviewProvider {
    static var previews: some View {
            List {
                CharacterListRowView(character: .init(id: nil,
                                                       name: nil,
                                                       image: nil,
                                                       episode: []))
                CharacterListRowView(character: .init(id: nil,
                                                       name: "preview",
                                                       image: nil,
                                                       episode: []))
            }
        }
}

//
//  CharacterListView.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import SwiftUI

struct CharacterListView: View {
    
    @StateObject private var data = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.charactersList ?? data.placeholders, id: \.id) { character in NavigationLink (
                    /// We can safely force unwrap here because every character has its own id.
                    destination: CharacterDetailView(id: character.id!),
                    label: {
                        CharacterListRowView(character: character)
                    })
                }
                .navigationTitle(AppConstants.CharactersListViewTitle)
                .task {
                    Task {
                        try await data.getCharacersList()
                    }
                }
            }
        }
    }
}

    struct CharacterListView_Previews: PreviewProvider {
        static var previews: some View {
            CharacterListView()
        }
    }


//
//  CharacterListViewModel.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import Foundation
import Apollo

class CharacterListViewModel: ObservableObject {
    
    @Published public var charactersList: [CharacterSmall]?
    public var placeholders = Array(repeating: CharacterSmall(id: GraphQLID(0), name: nil, image: nil, episode: []), count: 10)
    
    func getCharacersList() async throws {
        self.charactersList = try await NetworkManager.instance.getCharactersList()
    }
    
}

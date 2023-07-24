//
//  CharacterListViewModel.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import Foundation
import Apollo

final class CharacterListViewModel: ObservableObject {
    
    @Published public var charactersList: [CharacterSmall]?
    public var placeholders = Array(repeating: CharacterSmall(id: GraphQLID(0), name: nil, image: nil, episode: []), count: 10)
    public private(set) var totalPage: Int?
    public private(set) var totalCharacters: Int?
    public var currentPage = 1 {
        didSet {
            Task {
                try await getCharacersList()
            }
        }
    }
    public var shouldDisplayNextPage: Bool {
        if charactersList?.isEmpty == false,
           let totalPages = totalPage,
           currentPage < totalPages {
            return true
        }
        return false
    }
    
    
    
    @MainActor func getCharacersList() async throws {
        let fetchedPage = currentPage
        let result = try await NetworkManager.instance.getCharactersList(page: currentPage)
        if fetchedPage > 1 {
            charactersList?.append(contentsOf: result.character)
        } else {
            charactersList = result.character
        }
        totalPage = result.pages
        totalCharacters = result.totalCharacters
    }
    
}

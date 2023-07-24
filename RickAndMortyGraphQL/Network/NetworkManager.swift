//
//  NetworkManager.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import Foundation
import Apollo

final class NetworkManager {
    
    static let instance = NetworkManager()
    
    private init() {}
    
    private(set) lazy var apolloURL = ApolloClient(url: URL(string: AppConstants.apolloEndpointURL)!)
    
    @MainActor
    func getCharactersList(page: Int) async throws -> (character: [CharacterSmall], pages: Int?, totalCharacters: Int?) {
        return await withCheckedContinuation({ continuation in
            apolloURL.fetch(query: GetCharactersQuery(page: page)) { response in
                switch response {
                case .success(let characterList):
                    continuation.resume(returning: (character: characterList.data?.characters?.results?.compactMap({$0?.fragments.characterSmall}) ?? [], characterList.data?.characters?.info?.pages, totalCharacters: characterList.data?.characters?.info?.count))
                case .failure(let error):
                    print("GraphQL query error: \(error.localizedDescription)")
                }
            }
        })
    }
    
}

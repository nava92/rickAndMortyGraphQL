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
    func getCharactersList() async throws -> [CharacterSmall] {
        return await withCheckedContinuation({ continuation in
            apolloURL.fetch(query: GetCharactersQuery()) { response in
                switch response {
                case .success(let characterList):
                    continuation.resume(returning: characterList.data?.characters?.results?.compactMap({$0?.fragments.characterSmall}) ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
    }
    
}

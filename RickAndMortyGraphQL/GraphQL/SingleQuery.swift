//
//  SingleQuery.swift
//  RickAndMortyGraphQL
//
//  Created by Eduardo Navarrete Carmona on 22/07/23.
//

import Foundation
import Apollo
import SwiftUI

final class SingleQuery<Query: GraphQLQuery>: ObservableObject {
    
    @Published public var data: Query.Data?
    @Published public var error: Error?
    
    public init(query: Query) {
        loadData(query: query)
    }
    
    private func loadData(query: Query) {
        NetworkManager.instance.apolloURL.fetch(query: query) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let result):
                self.data = result.data
            case .failure(let error):
                self.error = error
            }
        }
    }
}

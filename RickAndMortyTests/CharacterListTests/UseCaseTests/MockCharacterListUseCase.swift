//
//  MockCharacterListUseCase.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation
@testable import RickAndMorty

final class MockCharacterListUseCase: CharacterListUseCaseProtocol {
    var result: Result<([Character], Bool), Error> = .success(([], false))
    
    var lastPage: Int?
    var lastSearchQuery: String?
    var lastStatusFilter: Character.CharacterStatus?
    
    init(result: Result<([Character], Bool), Error> = .success(([], false))) {
        self.result = result
    }
    
    func fetchCharacters(
        page: Int,
        searchQuery: String?,
        statusFilter: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool) {
        lastPage = page
        lastSearchQuery = searchQuery
        lastStatusFilter = statusFilter
        
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

//
//  CharacterListUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

protocol CharacterListUseCaseProtocol {
    func fetchCharacters(
        page: Int,
        searchQuery: String?,
        statusFilter: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool)
}

final class CharacterListUseCase: CharacterListUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
    }
    
    func fetchCharacters(
        page: Int,
        searchQuery: String?,
        statusFilter: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool) {
        let trimmedQuery = searchQuery?.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalQuery = trimmedQuery?.isEmpty == true ? nil : trimmedQuery
        
        return try await repository.getCharacters(
            page: page,
            name: finalQuery,
            status: statusFilter
        )
    }
}

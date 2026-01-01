//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(
        page: Int,
        name: String?,
        status: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool)
    
    func getCharacter(id: Int) async throws -> Character
}

final class CharacterRepository: CharacterRepositoryProtocol {
    private let service: CharacterServiceProtocol
    
    init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }
    
    func getCharacters(
        page: Int,
        name: String?,
        status: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool) {
        let dto = try await service.fetchCharacters(
            page: page,
            name: name,
            status: status?.rawValue.lowercased()
        )
        
        let characters = dto.results.map { $0.toDomain() }
        let hasMore = dto.info.next != nil
        
        return (characters, hasMore)
    }
    
    func getCharacter(id: Int) async throws -> Character {
        let dto = try await service.fetchCharacter(id: id)
        return dto.toDomain()
    }
}

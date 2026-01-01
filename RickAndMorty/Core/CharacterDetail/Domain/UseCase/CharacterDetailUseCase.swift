//
//  CharacterDetailUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//


import Foundation

protocol CharacterDetailUseCaseProtocol {
    func fetchCharacter(id: Int) async throws -> Character
}

final class CharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
    }
    
    func fetchCharacter(id: Int) async throws -> Character {
        return try await repository.getCharacter(id: id)
    }
}

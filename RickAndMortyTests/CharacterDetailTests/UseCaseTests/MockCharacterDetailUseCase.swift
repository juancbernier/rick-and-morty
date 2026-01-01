//
//  MockCharacterDetailUseCase.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation
@testable import RickAndMorty

final class MockCharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    var result: Result<Character, Error> = .success(.mock())
    var fetchCallCount = 0
    
    init(result: Result<Character, Error> = .success(.mock())) {
        self.result = result
    }
    
    func fetchCharacter(id: Int) async throws -> Character {
        fetchCallCount += 1
        
        switch result {
        case .success(let character):
            return character
        case .failure(let error):
            throw error
        }
    }
}

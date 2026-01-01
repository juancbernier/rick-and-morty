//
//  MockCharacterRepository.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation
@testable import RickAndMorty

final class MockCharacterRepository: CharacterRepositoryProtocol {
    var charactersResult: Result<([Character], Bool), Error> = .success(([], false))
    var characterResult: Result<Character, Error> = .success(.mock())
    
    var lastRequestedPage: Int?
    var lastRequestedName: String?
    var lastRequestedStatus: Character.CharacterStatus?
    
    init(
        charactersResult: Result<([Character], Bool), Error> = .success(([], false)),
        characterResult: Result<Character, Error> = .success(.mock())
    ) {
        self.charactersResult = charactersResult
        self.characterResult = characterResult
    }
    
    func getCharacters(
        page: Int,
        name: String?,
        status: Character.CharacterStatus?
    ) async throws -> (characters: [Character], hasMore: Bool) {
        lastRequestedPage = page
        lastRequestedName = name
        lastRequestedStatus = status
        
        switch charactersResult {
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
    }
    
    func getCharacter(id: Int) async throws -> Character {
        switch characterResult {
        case .success(let character):
            return character
        case .failure(let error):
            throw error
        }
    }
}

//
//  CharacterDetailUseCaseTests.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailUseCaseTests: XCTestCase {
    
    func testFetchCharacterSuccess() async throws {
        let mockCharacter = Character.mock(id: 1, name: "Rick Sanchez")
        let repository = MockCharacterRepository(
            characterResult: .success(mockCharacter)
        )
        let useCase = CharacterDetailUseCase(repository: repository)
        
        let result = try await useCase.fetchCharacter(id: 1)
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Rick Sanchez")
    }
    
    func testFetchCharacterFailure() async {
        let repository = MockCharacterRepository(
            characterResult: .failure(NetworkError.serverError(404))
        )
        let useCase = CharacterDetailUseCase(repository: repository)
        
        do {
            _ = try await useCase.fetchCharacter(id: 999)
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}

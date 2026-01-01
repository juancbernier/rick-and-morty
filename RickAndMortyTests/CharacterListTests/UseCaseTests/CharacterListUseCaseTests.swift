//
//  CharacterListUseCaseTests.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import XCTest
@testable import RickAndMorty

final class CharacterListUseCaseTests: XCTestCase {
    
    func testFetchCharactersSuccess() async throws {
        let mockCharacters = [
            Character.mock(id: 1, name: "Rick"),
            Character.mock(id: 2, name: "Morty")
        ]
        let repository = MockCharacterRepository(
            charactersResult: .success((mockCharacters, true))
        )
        let useCase = CharacterListUseCase(repository: repository)
        
        let result = try await useCase.fetchCharacters(
            page: 1,
            searchQuery: "Rick",
            statusFilter: .alive
        )
        
        XCTAssertEqual(result.characters.count, 2)
        XCTAssertTrue(result.hasMore)
        XCTAssertEqual(repository.lastRequestedPage, 1)
        XCTAssertEqual(repository.lastRequestedName, "Rick")
        XCTAssertEqual(repository.lastRequestedStatus, .alive)
    }
    
    func testFetchCharactersTrimsWhitespace() async throws {
        let repository = MockCharacterRepository()
        let useCase = CharacterListUseCase(repository: repository)
        
        _ = try? await useCase.fetchCharacters(
            page: 1,
            searchQuery: "  Rick  ",
            statusFilter: nil
        )
        
        XCTAssertEqual(repository.lastRequestedName, "Rick")
    }
    
    func testFetchCharactersEmptyQueryBecomesNil() async throws {
        let repository = MockCharacterRepository()
        let useCase = CharacterListUseCase(repository: repository)
        
        _ = try? await useCase.fetchCharacters(
            page: 1,
            searchQuery: "   ",
            statusFilter: nil
        )
        
        XCTAssertNil(repository.lastRequestedName)
    }
}

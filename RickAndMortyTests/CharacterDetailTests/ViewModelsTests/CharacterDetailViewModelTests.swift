//
//  CharacterDetailViewModelTests.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import XCTest
@testable import RickAndMorty

@MainActor
final class CharacterDetailViewModelTests: XCTestCase {
    
    func testInitialStateIsLoading() {
        let useCase = MockCharacterDetailUseCase()
        let viewModel = CharacterDetailViewModel(characterId: 1, useCase: useCase)
        
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    func testLoadCharacterSuccess() async {
        let mockCharacter = Character.mock(id: 1, name: "Rick Sanchez")
        let useCase = MockCharacterDetailUseCase(
            result: .success(mockCharacter)
        )
        let viewModel = CharacterDetailViewModel(characterId: 1, useCase: useCase)
        
        viewModel.loadCharacter()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if case .success(let character) = viewModel.state {
            XCTAssertEqual(character.id, 1)
            XCTAssertEqual(character.name, "Rick Sanchez")
        } else {
            XCTFail("Expected success state")
        }
    }
    
    func testLoadCharacterFailure() async {
        let useCase = MockCharacterDetailUseCase(
            result: .failure(NetworkError.serverError(404))
        )
        let viewModel = CharacterDetailViewModel(characterId: 999, useCase: useCase)
        
        viewModel.loadCharacter()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if case .failure = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected failure state")
        }
    }
    
    func testRetryCallsLoadCharacterAgain() async {
        let useCase = MockCharacterDetailUseCase()
        let viewModel = CharacterDetailViewModel(characterId: 1, useCase: useCase)
        
        viewModel.retry()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(useCase.fetchCallCount, 1)
    }
}

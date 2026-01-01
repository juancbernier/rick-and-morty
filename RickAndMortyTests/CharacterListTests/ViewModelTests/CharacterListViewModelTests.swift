//
//  CharacterListViewModelTests.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import XCTest
@testable import RickAndMorty

@MainActor
final class CharacterListViewModelTests: XCTestCase {
    
    func testInitialStateIsIdle() {
        let useCase = MockCharacterListUseCase()
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        XCTAssertEqual(viewModel.state, .initializing)
    }
    
    func testLoadInitialDataSuccess() async {
        let mockCharacters = [
            Character.mock(id: 1, name: "Rick"),
            Character.mock(id: 2, name: "Morty")
        ]
        let useCase = MockCharacterListUseCase(
            result: .success((mockCharacters, true))
        )
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        viewModel.loadInitialData()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if case .success(let characters) = viewModel.state {
            XCTAssertEqual(characters.count, 2)
            XCTAssertEqual(characters.first?.name, "Rick")
        } else {
            XCTFail("Expected success state")
        }
    }
    
    func testSearchDebounceAndReset() async {
        let useCase = MockCharacterListUseCase()
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        viewModel.loadInitialData()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        viewModel.searchText = "Rick"
        
        try? await Task.sleep(nanoseconds: 400_000_000)
        
        XCTAssertEqual(useCase.lastPage, 1)
        XCTAssertEqual(useCase.lastSearchQuery, "Rick")
    }
    
    func testStatusFilterChangeTriggersNewRequest() async {
        let useCase = MockCharacterListUseCase()
        let viewModel = CharacterListViewModel(useCase: useCase)
        
        viewModel.loadInitialData()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        viewModel.selectedStatus = .alive
        
        try? await Task.sleep(nanoseconds: 400_000_000)
        
        XCTAssertEqual(useCase.lastStatusFilter, .alive)
    }
}

//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

protocol CharacterDetailViewModelProtocol: ObservableObject {
    var state: CharacterDetailViewModel.State { get }
    
    func loadCharacter()
    func retry()
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    
    enum State: Equatable {
        case loading
        case success(Character)
        case failure(String)
    }
    
    @Published
    private(set) var state: State = .loading
    
    private let useCase: CharacterDetailUseCaseProtocol
    private let characterId: Int
    
    init(characterId: Int, useCase: CharacterDetailUseCaseProtocol = CharacterDetailUseCase()) {
        self.characterId = characterId
        self.useCase = useCase
    }
    
    func loadCharacter() {
        state = .loading
        
        Task {
            do {
                let character = try await useCase.fetchCharacter(id: characterId)
                state = .success(character)
            } catch {
                state = .failure(error.localizedDescription)
            }
        }
    }
    
    func retry() {
        loadCharacter()
    }
}

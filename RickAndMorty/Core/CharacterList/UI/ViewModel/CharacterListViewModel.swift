//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation
import Combine

protocol CharacterListViewModelProtocol: ObservableObject {
    var state: CharacterListViewModel.State { get }
    var searchText: String { get set }
    var selectedStatus: Character.CharacterStatus? { get set }
    
    func loadInitialData()
    func loadMoreIfNeeded(currentItem: Character, allCharacters: [Character])
    func retry()
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    enum State: Equatable {
        case initializing
        case loading
        case success([Character])
        case failure(String)
        case empty
    }
    
    @Published
    private(set) var state: State = .initializing
    
    @Published
    var searchText: String = ""
    
    @Published
    var selectedStatus: Character.CharacterStatus? = nil
    
    private var currentPage = 1
    private var hasMorePages = true
    private var isLoadingMore = false
    
    private let useCase: CharacterListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: CharacterListUseCaseProtocol = CharacterListUseCase()) {
        self.useCase = useCase
        setupSearchDebounce()
    }
    
    private func setupSearchDebounce() {
        Publishers.CombineLatest($searchText, $selectedStatus)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates { $0.0 == $1.0 && $0.1 == $1.1 }
            .sink { [weak self] _, _ in
                self?.resetAndFetch()
            }
            .store(in: &cancellables)
    }
    
    func loadInitialData() {
        guard case .initializing = state else { return }
        fetchCharacters()
    }
    
    func loadMoreIfNeeded(currentItem: Character, allCharacters: [Character]) {
        guard hasMorePages, !isLoadingMore else { return }
        let thresholdIndex = allCharacters.index(allCharacters.endIndex, offsetBy: -5)
        if let itemIndex = allCharacters.firstIndex(where: { $0.id == currentItem.id }),
           itemIndex >= thresholdIndex {
            loadMore()
        }
    }
    
    func retry() {
        resetAndFetch()
    }
    
    private func resetAndFetch() {
        currentPage = 1
        hasMorePages = true
        isLoadingMore = false
        fetchCharacters()
    }
    
    private func loadMore() {
        guard !isLoadingMore, hasMorePages else { return }
        currentPage += 1
        fetchCharacters(isLoadingMore: true)
    }
    
    private func fetchCharacters(isLoadingMore: Bool = false) {
        self.isLoadingMore = isLoadingMore
        
        if !isLoadingMore {
            state = .loading
        }
        
        Task {
            do {
                let result = try await useCase.fetchCharacters(
                    page: currentPage,
                    searchQuery: searchText,
                    statusFilter: selectedStatus
                )
                handleSuccess(
                    newCharacters: result.characters,
                    hasMore: result.hasMore,
                    isLoadingMore: isLoadingMore
                )
            } catch {
                handleFailure(error: error, isLoadingMore: isLoadingMore)
            }
        }
    }
    
    private func handleSuccess(
        newCharacters: [Character],
        hasMore: Bool,
        isLoadingMore: Bool
    ) {
        self.hasMorePages = hasMore
        self.isLoadingMore = false
        
        if isLoadingMore {
            if case .success(let existing) = state {
                state = .success(existing + newCharacters)
            }
        } else {
            if newCharacters.isEmpty {
                state = .empty
            } else {
                state = .success(newCharacters)
            }
        }
    }
    
    private func handleFailure(error: Error, isLoadingMore: Bool) {
        self.isLoadingMore = false
        
        if !isLoadingMore {
            state = .failure(error.localizedDescription)
        }
    }
}

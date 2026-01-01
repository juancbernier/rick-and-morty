//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelProtocol {
    
    @StateObject
    private var viewModel: ViewModel
    
    init(_ viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterSection
                Divider()
                contentView
            }
            .navigationTitle("Rick & Morty")
            .onAppear {
                viewModel.loadInitialData()
            }
        }
    }
    
    private var filterSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search characters...", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                
                if !viewModel.searchText.isEmpty {
                    Button(action: { viewModel.searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            Picker("Status", selection: $viewModel.selectedStatus) {
                ForEach(Character.CharacterStatus.allCasesForFilter, id: \.self) { status in
                    Text(Character.CharacterStatus.filterDisplayName(status))
                        .tag(status)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
    
    @ViewBuilder
    private var contentView: some View {
        Group {
            switch viewModel.state {
            case .loading, .initializing:
                CharacterListLoadingView()
                
            case .success(let characters):
                successView(characters: characters)
                
            case .failure(let message):
                CharacterListFailureView(
                    errorMessage: message,
                    retryAction: { viewModel.retry() }
                )
                
            case .empty:
                CharacterListEmptyView()
            }
        }
    }
    
    private func successView(characters: [Character]) -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(characters) { character in
                    NavigationLink(value: character) {
                        CharacterRow(character: character)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.plain)
                    .onAppear {
                        viewModel.loadMoreIfNeeded(
                            currentItem: character,
                            allCharacters: characters
                        )
                    }
                    
                    if character.id != characters.last?.id {
                        Divider()
                            .padding(.leading, 112)
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterListView(CharacterListViewModel())
}

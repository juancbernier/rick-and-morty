//
//  CharacterDetailView.swift
//  TestRickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct CharacterDetailView<ViewModel>: View where ViewModel: CharacterDetailViewModelProtocol {

    @StateObject
    private var viewModel: ViewModel
    
    init(_ viewModel: @autoclosure @escaping () -> ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                CharacterDetailLoadingView()
                
            case .success(let character):
                successView(character: character)
                
            case .failure(let message):
                CharacterDetailFailureView(
                    errorMessage: message,
                    retryAction: { viewModel.retry() }
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadCharacter()
        }
    }
    
    private func successView(character: Character) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                AsyncImageView(
                    url: character.image,
                    height: 300,
                    cornerRadius: 0
                )
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    infoSection(title: "Status") {
                        HStack {
                            Circle()
                                .fill(statusColor(for: character.status))
                                .frame(width: 10, height: 10)
                            Text(character.status.displayName)
                        }
                    }
                    
                    infoSection(title: "Species", value: character.species)
                    infoSection(title: "Gender", value: character.gender)
                    
                    Divider()
                    
                    infoSection(title: "Origin", value: character.origin.name)
                    infoSection(title: "Last known location", value: character.location.name)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Episodes")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("\(character.episode.count) episodes")
                            .font(.body)
                    }
                }
                .padding()
            }
        }
    }
    
    private func infoSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            content()
                .font(.body)
        }
    }
    
    private func infoSection(title: String, value: String) -> some View {
        infoSection(title: title) {
            Text(value)
        }
    }
    
    private func statusColor(for status: Character.CharacterStatus) -> Color {
        switch status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(CharacterDetailViewModel(characterId: 1))
    }
}

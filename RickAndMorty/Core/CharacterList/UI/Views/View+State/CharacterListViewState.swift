//
//  CharacterListLoadingView.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct CharacterListLoadingView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<10, id: \.self) { index in
                    CharacterRowPlaceholder()
                    
                    if index < 9 {
                        Divider()
                            .padding(.leading, 112)
                    }
                }
            }
        }
        .disabled(true)
    }
}

struct CharacterListEmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            Text("No characters found")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Try adjusting your search or filters")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct CharacterListFailureView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Oops!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(errorMessage)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: retryAction) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

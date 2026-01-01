//
//  CharacterDetailLoadingView.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

// MARK: - Loading
struct CharacterDetailLoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading character details...")
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Failure
struct CharacterDetailFailureView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Failed to load")
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

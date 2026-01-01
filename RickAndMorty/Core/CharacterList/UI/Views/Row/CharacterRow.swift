//
//  CharacterRow.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImageView(
                url: character.image,
                width: 80,
                height: 80,
                cornerRadius: 12
            )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(statusColor(for: character.status))
                        .frame(width: 8, height: 8)
                    
                    Text(character.status.displayName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
    
    private func statusColor(for status: Character.CharacterStatus) -> Color {
        switch status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

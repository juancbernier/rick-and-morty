//
//  CharacterRowPlaceholder.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct CharacterRowPlaceholder: View {
    var body: some View {
        HStack(spacing: 16) {
            ShimmerShape(
                width: 80,
                height: 80,
                cornerRadius: 12
            )
            
            VStack(alignment: .leading, spacing: 8) {
                ShimmerShape(
                    width: 150,
                    height: 18,
                    cornerRadius: 4
                )
                
                HStack(spacing: 4) {
                    ShimmerShape(
                        width: 8,
                        height: 8,
                        cornerRadius: 4
                    )
                    
                    ShimmerShape(
                        width: 60,
                        height: 14,
                        cornerRadius: 4
                    )
                }
                
                ShimmerShape(
                    width: 100,
                    height: 14,
                    cornerRadius: 4
                )
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

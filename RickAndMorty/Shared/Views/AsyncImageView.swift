//
//  AsyncImageView.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    let width: CGFloat?
    let height: CGFloat?
    let cornerRadius: CGFloat
    
    init(
        url: String,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        cornerRadius: CGFloat = 0
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                shimmerPlaceholder
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            case .failure:
                failurePlaceholder
                
            @unknown default:
                shimmerPlaceholder
            }
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    // MARK: - Shimmer Placeholder
    private var shimmerPlaceholder: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(.systemGray5),
                                Color(.systemGray6),
                                Color(.systemGray5)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .white, .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .rotationEffect(.degrees(70))
                            .offset(x: shimmerOffset)
                    )
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    shimmerOffset = 300
                }
            }
    }
    
    @State private var shimmerOffset: CGFloat = -300
    
    private var failurePlaceholder: some View {
        ZStack {
            Color(.systemGray6)
            
            Image(systemName: "photo")
                .font(.system(size: min(width ?? 100, height ?? 100) * 0.3))
                .foregroundColor(.secondary)
        }
    }
}

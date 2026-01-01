//
//  View+.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerModifier())
    }
}

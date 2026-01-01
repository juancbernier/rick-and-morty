//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView(CharacterListViewModel())
        }
    }
}

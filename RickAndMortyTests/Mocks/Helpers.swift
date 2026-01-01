//
//  Helpers.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation
@testable import RickAndMorty

extension Character {
    static func mock(
        id: Int = 1,
        name: String = "Test Character",
        status: CharacterStatus = .alive,
        species: String = "Human",
        gender: String = "Male",
        image: String = "https://example.com/image.jpg"
    ) -> Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: "",
            gender: gender,
            origin: Location(name: "Earth", url: ""),
            location: Location(name: "Earth", url: ""),
            image: image,
            episode: [],
            url: "",
            created: ""
        )
    }
}

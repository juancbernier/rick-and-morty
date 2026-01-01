//
//  CharactersResponseDTO.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

struct CharactersResponseDTO: Codable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

struct InfoDTO: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationDTO
    let location: LocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationDTO: Codable {
    let name: String
    let url: String
}

extension CharacterDTO {
    func toDomain() -> Character {
        Character(
            id: id,
            name: name,
            status: Character.CharacterStatus(rawValue: status) ?? .unknown,
            species: species,
            type: type,
            gender: gender,
            origin: Character.Location(name: origin.name, url: origin.url),
            location: Character.Location(name: location.name, url: location.url),
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}

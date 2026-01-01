//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Juan Bernier on 1/01/26.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?
    ) async throws -> CharactersResponseDTO
    
    func fetchCharacter(id: Int) async throws -> CharacterDTO
}

final class CharacterService: CharacterServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?
    ) async throws -> CharactersResponseDTO {
        var components = URLComponents(string: "\(baseURL)/character")
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if let name = name, !name.isEmpty {
            components?.queryItems?.append(URLQueryItem(name: "name", value: name))
        }
        
        if let status = status {
            components?.queryItems?.append(URLQueryItem(name: "status", value: status))
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(CharactersResponseDTO.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchCharacter(id: Int) async throws -> CharacterDTO {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(CharacterDTO.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

//
//  MovieModel.swift
//  Coppel
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import Foundation

struct MovieModel: Decodable {
    let results: [Movie]
    let total_pages: Int
}

struct Movie: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let poster_path: String
    let vote_average: Float
    let release_date: String
    let genres: [Genre]?
}

struct Genre: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
}

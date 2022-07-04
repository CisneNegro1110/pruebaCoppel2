//
//  MovieView.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieView: View {
    var movie: Movie
    var body: some View {
        HStack(spacing: 15) {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(movie.overview ?? "")
                    .lineLimit(4)
                Spacer()
                RatingView(rating: movie.vote_average)
            }
        }
    }
}

struct RatingView: View {
    var rating: Float
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 13, height: 13)
                .foregroundColor(.orange)
            Text(String(format: "%.1f", rating))
                .fontWeight(.medium)
        }
    }
}

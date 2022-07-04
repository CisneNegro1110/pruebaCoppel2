//
//  DetailsView.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack(alignment: .top) {
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Button {
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                                .foregroundColor(Color.primary)
                        }
                        Spacer()
                    }.padding()
                        .padding(.top)
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 7) {
                    Text(movie.title)
                        .font(.largeTitle)
                    RatingView(rating: movie.vote_average)
                    Spacer()
                }
                HStack(spacing: 8) {
                    ForEach(viewModel.movie?.genres ?? Array.init(repeating: Genre(id: 0, name: "Loading..."), count: 3)) { genre in
                        Text(genre.name)
                            .redacted(reason: viewModel.movie != nil ? .init() : .placeholder)
                        if viewModel.movie?.genres?.last != genre {
                            Circle().frame(width: 6, height: 6)
                        }
                    }
                    Spacer()
                }
                Text(movie.release_date)
                Text(movie.overview ?? "")
                Button {
                    print("Play")
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play Trailer")
                    }
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.primary, lineWidth: 1))
                }
                .padding(.bottom)
            }
            .padding()
            .background(RoundedCorners(corners: [.topLeft, .topRight], radius: 30).fill(Color.white).shadow(radius: 5))
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            viewModel.fetchMovie(movie: movie)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(id: 0, title: "", overview: "", poster_path: "", vote_average: 0.1, release_date: "", genres: nil), viewModel: MovieViewModel())
    }
}

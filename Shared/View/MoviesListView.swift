//
//  MoviesListView.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MovieViewModel
    var movies: [Movie]
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie, viewModel: viewModel)) {
                        MovieView(movie: movie)
                        .padding(.vertical)
                            .onAppear(){
                                viewModel.fetchMoreData(movie: movie)
                            }
                    }
                }
            }
            .navigationBarTitle("Popular movie")
        }
        
    }
}

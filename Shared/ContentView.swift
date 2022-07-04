//
//  ContentView.swift
//  Shared
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                if let movies = viewModel.movies {
                    MoviesListView(viewModel: viewModel, movies: movies)
                } else {
                   LoadingView()
                }
            }
            .navigationTitle("Popular Movies")
        }
        .onAppear() {
            viewModel.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

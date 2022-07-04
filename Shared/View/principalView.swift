//
//  principalView.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 04/07/22.
//

import SwiftUI

struct principalView: View {
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        VStack {
            TabView {
                LoginView()
                    .tabItem {
                    Label("Login", systemImage: "person")
                }
                if let movies = viewModel.movies {
                    MoviesListView(viewModel: viewModel, movies: movies)
                        .tabItem {
                        Label("Movie", systemImage: "ticket")
                    }
                    .onAppear() {
                        viewModel.fetchData()
                    }
                } else {
                    LoadingView()
                }
            }
        }
    }
}

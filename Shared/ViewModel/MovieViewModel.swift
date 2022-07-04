//
//  MovieViewModel.swift
//  Coppel
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var movie: Movie?
    var codingKey = "4d33ddd6ae0d5bab45825862a78e481e"
    var page: Int = 1
    var totalPages: Int = 1
    var isFetchingData = false
    func fetchMoreData(movie: Movie) {
        if movies.last == movie && page <= totalPages && !isFetchingData {
            page += 1
            fetchData()
        }
    }
    func fetchData() {
        let url = URL(string:
                        "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(codingKey)&page=\(page)")
        isFetchingData = true
        URLSession.shared.dataTask(with: url!) { data, response, error in
            self.isFetchingData = false
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let discover = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.totalPages = discover.total_pages
                    DispatchQueue.main.async {
                        self.movies += discover.results
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
        } .resume()
    }
    func fetchMovie(movie: Movie) {
        let url = URL(string:
                        "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=\(codingKey)")
        isFetchingData = true
        URLSession.shared.dataTask(with: url!) { data, response, error in
            self.isFetchingData = false
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        self.movie = movie
                    }
                } catch (let error) {
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
        } .resume()
    }
}

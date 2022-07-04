//
//  ContentView.swift
//  Shared
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()
    var body: some View {
        principalView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



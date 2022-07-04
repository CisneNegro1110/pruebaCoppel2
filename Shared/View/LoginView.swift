//
//  LogginView.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 04/07/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var vmlogin = requestToken()
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $vmlogin.userName)
                TextField("Password", text: $vmlogin.password)
                Button("Login") {
                    vmlogin.loginWithToken()
                }
                Text(vmlogin.message)
            }.padding()
                .onAppear() {
                    vmlogin.getRequestToken()
                }
                .navigationBarTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

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
                Image("movieImage")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding()
                TextField("Username", text: $vmlogin.userName)
                SecureField("Password", text: $vmlogin.password)
                
               
                Button("Login") {
                    vmlogin.loginWithToken()
                }
                Text(vmlogin.message)
               Spacer()
            }.padding()
                .onAppear() {
                    vmlogin.getRequestToken()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

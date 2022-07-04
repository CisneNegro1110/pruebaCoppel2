//
//  requestToken.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 04/07/22.
//

import Foundation
import Combine

class requestToken: ObservableObject {
    let apiKey = "4d33ddd6ae0d5bab45825862a78e481e"
    let getTokenMethod = "authentication/token/new"
    let baseURLSecureString = "https://api.themoviedb.org/3/"
    var requestToken: String = ""
    let session = URLSession.shared
    @Published var userName = "CisneNegro44"
    @Published var password = "tostitos"
    @Published var message = ""
    @Published var statusLogin = ""
    @Published var isLogin = false
    
    func getRequestToken() {
        let urlString = baseURLSecureString + getTokenMethod + "?api_key=" + apiKey
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.message = "Login Failed. (Request token.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let requestToken = parsedResult["request_token"] as? String {
                    self.requestToken = requestToken
                    
                } else {
                    DispatchQueue.main.async {
                        self.message = "Login Failed. (Request token.)"
                    }
                    print("Could not find request_token in \(parsedResult)")
                }
            }
        }
        task.resume()
    }

    let loginMethod = "authentication/token/validate_with_login"
    func loginWithToken() {
        let parameters = "?api_key=\(apiKey)&request_token=\(requestToken)&username=\(self.userName)&password=\(self.password)"
        let urlString = baseURLSecureString + loginMethod + parameters
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.message = "Login Failed. (Login Step.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let success = parsedResult["success"] as? Bool {
                    DispatchQueue.main.async {
                        self.message = "Login status: \(success)"
                      //  self.getSessionID()
                        self.isLogin = true
                    }
                } else {
                    if let status_code = parsedResult["status_code"] as? Int {
                        DispatchQueue.main.async {
                            let message = parsedResult["status_message"]
                            self.message = "\(status_code): \(message!)"
                           
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.message = "Login Failed. (Login Step.)"
                        }
                        print("Could not find success in \(parsedResult)")
                    }
                }
            }
        }
        task.resume()
    }

    let getSessionIdMethod = "authentication/session/new"
    var sessionID: String = ""
    func getSessionID() {
        let parameters = "?api_key=\(apiKey)&request_token=\(String(describing: requestToken))"
        let urlString = baseURLSecureString + getSessionIdMethod + parameters
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.message = "Login Failed. (Session ID.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let sessionID = parsedResult["session_id"] as? String {
                    self.sessionID = sessionID
                    DispatchQueue.main.async {
                        self.message = "Session ID: \(sessionID)"
                        //self.getUserID()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.message = "Login Failed. (Session ID.)"
                    }
                    print("Could not find session_id in \(parsedResult)")
                }
            }
        }
        task.resume()
    }

    let getUserIdMethod = "account"
    var userID: Int = 0
    func getUserID() {
        let urlString = baseURLSecureString + getUserIdMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.message = "Login Failed. (Get userID.)"
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let userID = parsedResult["id"] as? Int {
                    self.userID = userID
                    DispatchQueue.main.async {
                        self.message = "your user id: \(userID)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.message = "Login Failed. (Get userID.)"
                    }
                    print("Could not find user id in \(parsedResult)")
                }
            }
        }
        task.resume()
    }

    func completeLogin() {
        let getFavoritesMethod = "account/\(userID)/favorite/movies"
        let urlString = baseURLSecureString + getFavoritesMethod + "?api_key=" + apiKey + "&session_id=" + sessionID
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest) { data, response, downloadError in
            if let error = downloadError {
                DispatchQueue.main.async {
                    self.message = "Cannot retrieve information about user \(String(describing: self.userID))."
                }
                print("Could not complete the request \(error)")
            } else {
                let parsedResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                if let results = parsedResult["results"] as? NSArray {
                    DispatchQueue.main.async {
                        let firstFavorite = results.firstObject as? NSDictionary
                        let title = firstFavorite?.value(forKey: "title")
                        self.message = "Title: \(title ?? "")"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.message = "Cannot retrieve information about user \(self.userID)."
                    }
                    print("Could not find 'results' in \(parsedResult)")
                }
            }
        }
        task.resume()
    }
}

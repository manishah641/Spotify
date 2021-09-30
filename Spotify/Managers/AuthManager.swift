//
//  AuthManager.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
struct Constant {
    static let clientID = "f6b88cdd24af4acd956cc5a55b262c44"
    static let clientSecret = "ec547b62df9f4fb78c5d8d134568dcfe"
    static let tokenApiURL = "https://accounts.spotify.com/api/token"
    static let redirectURI = "https://roadway.app"
    static  let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
}
final class AuthManager{
    
    static let shared = AuthManager()
    private var refreshingToken = false
    public var SignInURL : URL?{
        let base = "https://accounts.spotify.com/authorize"
      
       
        let string = "\(base)" + "?response_type=code&client_id=\(Constant.clientID)&scope=\(Constant.scopes)&redirect_uri=\(Constant.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    private init(){}
    
    var isSignedIn : Bool {
        return accessToken != nil
    }
    
    private var accessToken:String?{
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken:String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate:Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken:Bool{
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinute:TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinute) >= (expirationDate)
      
    }
    public func exchangeCodeForToken(code:String,complition:@escaping((Bool) -> Void)){
        guard let url = URL(string: Constant.tokenApiURL) else {
            return
        }
        var componenets = URLComponents()
        componenets.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constant.redirectURI)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = componenets.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        let basicToken = Constant.clientID+":"+Constant.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Fail to get base 64")
            complition(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
       let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                print("got error with data task")
                complition(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponce.self,from:data)
                self?.cacheToken(result: result)
                complition(true)
            }
            catch{
                print(error.localizedDescription)
                complition(false)
             
            }
        }
        dataTask.resume()
        
    }
    private func cacheToken(result:AuthResponce){
        UserDefaults.standard.set(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
        }

        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    private var onRefreshBlocks = [((String)-> Void)]()
    
    /// Supplies valid Token to be used with Api calls
    
    public func withValidToken(complition: @escaping (String) -> Void){
        guard !refreshingToken else {
            onRefreshBlocks.append(complition)
            return
        }
        if shouldRefreshToken{
            refreshIfNeeded {[weak self] sucsess in
                if let token = self?.accessToken,sucsess {
                    complition(token)
                }
            }
            
        }else if let token = accessToken {
            complition(token)
        }
    }
    public func refreshIfNeeded(complition:((Bool)-> Void)?){
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            complition?(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
//        refresh Token
        
        guard let url = URL(string: Constant.tokenApiURL) else {
            return
        }
        refreshingToken = true
        var componenets = URLComponents()
        componenets.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = componenets.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        let basicToken = Constant.clientID+":"+Constant.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Fail to get base 64")
            complition?(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
       let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
        self?.refreshingToken = false
            guard let data = data, error == nil else {
                print("got error with data task")
                complition?(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponce.self,from:data)
                self?.onRefreshBlocks.forEach{$0(result.access_token)}
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                complition?(true)
            }
            catch{
                print(error.localizedDescription)
                complition?(false)
             
            }
        }
        dataTask.resume()
        
        
    }
}

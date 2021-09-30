//
//  APICaller.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
final class APICaller{
    static let shared = APICaller()
    private init(){}
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"

    }
    enum APIError:Error {
        case failedToGetData
    }

    //MARK: - Search
    public func search(with query :String,complition:@escaping(Result<[SearchResult],Error>)-> Void){
        createRequest(
            with: URL(string: Constants.baseAPIURL+"/search?limit=10&type=album,track,artist,playlist&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed ) ?? "")"),
            type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    complition(.failure(APIError.failedToGetData))
                    return
                }
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
                    let result = try JSONDecoder().decode(SearchResultResponce.self, from: data)
                    var searchResults :[SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap { .track(model: $0) })
                    searchResults.append(contentsOf: result.albums.items.compactMap { .album(model: $0) })
                    searchResults.append(contentsOf: result.playlists.items.compactMap { .playlist(model: $0) })
                    searchResults.append(contentsOf: result.artists.items.compactMap { .artist(model: $0) })
                    complition(.success(searchResults))
                    
                }catch{
                    print(error.localizedDescription)
                    
                }
            }
            task.resume()
        }
    }
    //MARK: - Albums
    public func getAlbumDetails(for album:Album,complition:@escaping(Result<AlbumDetailsResponce,Error>)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/"+album.id),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    complition(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AlbumDetailsResponce.self, from: data)
                    complition(.success(result))
                    
                }catch{
                    complition(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylist(completion:@escaping(Result<[Playlist],Error>)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data ,error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LibraryPlaylistReponce.self, from: data)
                    completion(.success(result.items))        
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name:String,completion:@escaping(Bool)-> Void){
        getcurrentUserProfile { [weak self]result in
            switch result{
            case .success(let profile):
                let urlString = Constants.baseAPIURL+"/users/\(profile.id)/playlists"
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name" : name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data,error == nil else {
                            completion(false)
                            return
                        }
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let responce = result as? [String:Any],responce["id"] as? String != nil {
                                completion(true)
                            }else {
                                completion(false)
                            }
                            
                        }catch{
                            print(error.localizedDescription)
                            completion(false)
                        }

                    }
                    task.resume()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    public func addTrackToPlaylist(track:AudioTrack,
                                   playlist:Playlist,
                                   completion:@escaping(Bool)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/\(playlist.id)/tracks"),
                      type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris":[
                    "spotify:track:\(track.id)"
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task  =  URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data ,error == nil else {
                    completion(false)
                    return
                }
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let responce = result as? [String:Any], responce["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                }
                catch {
                    print(error.localizedDescription)
                    completion(false)
                    
                }

            }
            task.resume()
            
        }
        
    }
    
    public func removeTrackFromPlaylist(track:AudioTrack,
                                        playlist:Playlist,
                                        completion:@escaping(Bool)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/\(playlist.id)/tracks"),
                      type: .DELETE) { baseRequest in
            var request = baseRequest
            let json : [String:Any] = [
                "tracks":[
                    [
                        "uri":"spotify:track:\(track.id)"
                    ]
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task  =  URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data ,error == nil else {
                    completion(false)
                    return
                }
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let responce = result as? [String:Any], responce["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                }
                catch {
                    print(error.localizedDescription)
                    completion(false)
                }

            }
            task.resume()
            
        }
        
    }
    public func getCurrentUserAlbums(completion:@escaping (Result<[Album],Error>) -> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/albums"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(LibraryAlbumReponce.self, from: data)
                    completion(.success(result.items.compactMap({ $0.album})))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func saveAlbum(album:Album,completion:@escaping (Bool)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/albums?ids=\(album.id)"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { _, responce, error in
                guard let code = (responce as? HTTPURLResponse)?.statusCode, error == nil else {
                    completion(false)
                    return
                }
             completion(code == 200)
            }
            task.resume()
        }
    }
    
    
    //MARK: - Playlists
    public func getPlaylistDetails(for playlist:Playlist,complition:@escaping(Result<PlaylistDetailsResponce,Error>)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/"+playlist.id),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    complition(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(PlaylistDetailsResponce.self, from: data)
                    complition(.success(result))
                }catch{
                    complition(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - Profile
    
    public func getcurrentUserProfile(complition:@escaping (Result<UserProfile,Error>)-> Void){
        AuthManager.shared.withValidToken {[weak self] token in
            self?.createRequest(with: URL(string: Constants.baseAPIURL+"/me"), type: .GET) { baseRequest in
                let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                    guard let data = data ,error == nil else {
                        complition(.failure(APIError.failedToGetData))
                        return
                    }
                    do {
                        //                        let  result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        let result = try JSONDecoder().decode(UserProfile.self, from: data)
                        complition(.success(result))
                    }catch{
                        complition(.failure(APIError.failedToGetData))
                    }
                }
                task.resume()
                
            }
            
        }
    }
    public func getRecomendedGenres(completion:@escaping((Result<RecommendedGenresResponce,Error>))-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations/available-genre-seeds"), type: .GET) { request in
            let task  = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponce.self, from: data)
                    completion(.success(result))
                    
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
        
    }
    public func getRecomandations(genres:Set<String>,completion:@escaping ((Result<RecommendationsResponce,Error>))-> Void){
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            let task  = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponce.self, from: data)
                    completion(.success(result))
                    
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
        
    }
    public func getFeaturedPlaylist(completion:@escaping((Result<FeaturedPlaylistResponce,Error>))->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task  = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponce.self, from: data)
                    //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    //                    print(json)
                    completion(.success(result))
                    
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
        
    }
    public func getNewRealases(completion:@escaping((Result<NewReleasesReponces,Error>))->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/new-releases"), type: .GET) { request in
            let task  = URLSession.shared.dataTask(with: request) { data ,_, error in
                guard let data = data , error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(NewReleasesReponces.self, from: data)
                    //                    print(result)
                    completion(.success(result))
                    
                    
                }catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    
                    
                }
            }
            task.resume()
        }
        
        
        
    }
    //MARK: - Category
    public func getCategories(completion:@escaping (Result<[Category],Error>)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponce.self, from: data)
                    completion(.success(result.categories.items)
                    )  
                }catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
            
        }
    }
    
    public func getCategoriesPlaylist(category:Category,completion:@escaping (Result<[Playlist],Error>)-> Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories/\(category.id)/playlists?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryplaylistsResponce.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                }catch {
                    print(error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
            task.resume()
            
        }
    }
    
    
    //MARK: - Private
    enum HTTPMethod:String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    private func createRequest(
        with url:URL?,
        type:HTTPMethod,
        complition:@escaping (URLRequest)-> Void){
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            complition(request)
        }
        
    }
}

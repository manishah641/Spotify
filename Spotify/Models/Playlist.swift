//
//  Playlist.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
struct Playlist:Codable {
    
    let description:String
    let external_urls :[String:String]
    let id :String
    let images:[ApiImage]
    let name:String
    let owner:User
    

}

//
//  Artist.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation

struct Artist:Codable {
    
    let id:String
    let name:String
    let type:String
    let images:[ApiImage]?
    let external_urls :[String:String]
}

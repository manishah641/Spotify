//
//  PlaylistDetailsResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 18/09/2021.
//

import Foundation
struct PlaylistDetailsResponce:Codable {
    let description:String
    let external_urls:[String:String]
    let id:String
    let images:[ApiImage]
    let name:String
    let tracks:PlaylistTracksResponce
    
}
struct PlaylistTracksResponce:Codable {
    let items:[PlaylistItem]
}
struct PlaylistItem:Codable {
    let track : AudioTrack
    
}


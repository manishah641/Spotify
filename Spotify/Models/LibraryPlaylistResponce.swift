//
//  LibraryPlaylistResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 23/09/2021.
//

import Foundation


struct LibraryPlaylistReponce:Codable{
    let items:[Playlist]
}

struct LibraryAlbumReponce:Codable{
    let items:[SavedAlbum]
}
struct SavedAlbum:Codable {
    let added_at:String
    let album:Album
}

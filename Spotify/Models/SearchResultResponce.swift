//
//  SearchResultResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 21/09/2021.
//

import Foundation
struct SearchResultResponce:Codable {
    let albums:SearchAlbumResponce
    let artists:SearchArtistsResponce
    let tracks:SearchTracksResponce
    let playlists:SearchPlaylistsResponce
}
struct SearchAlbumResponce:Codable {
    let items:[Album]
}
struct SearchPlaylistsResponce:Codable {
    let items:[Playlist]
}
struct SearchArtistsResponce:Codable{
    let items:[Artist]
}
struct SearchTracksResponce:Codable {
    let items:[AudioTrack]
}

//
//  SearchResult.swift
//  Spotify
//
//  Created by Syed Muhammad on 21/09/2021.
//

import Foundation
enum SearchResult{
    case artist(model:Artist)
    case album(model:Album)
    case track(model:AudioTrack)
    case playlist(model:Playlist)
}

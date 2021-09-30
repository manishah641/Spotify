//
//  NewFeaturedResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 13/09/2021.
//

import Foundation

struct FeaturedPlaylistResponce:Codable {
    let playlists : FeaturedResponce
}
struct CategoryplaylistsResponce:Codable {
    let playlists : FeaturedResponce
}
struct FeaturedResponce:Codable{
    let items:[Playlist]

}

struct User:Codable {
    let display_name:String
    let external_urls:[String:String]
    let id:String
}




//owner =                 {
//                    "display_name" = Spotify;
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/user/spotify";
//                    };
//                    href = "https://api.spotify.com/v1/users/spotify";
//                    id = spotify;
//                    type = user;
//                    uri = "spotify:user:spotify";
//                };

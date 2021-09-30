//
//  NewReleasesReponces.swift
//  Spotify
//
//  Created by Syed Muhammad on 12/09/2021.
//

import Foundation
//
struct NewReleasesReponces:Codable {
    let albums:AlbumsResponce
}
struct AlbumsResponce:Codable{
    let items:[Album]
}
struct Album:Codable{
    let album_type:String
    let available_markets:[String]
    let id:String
    var images : [ApiImage]
    let name:String
    let release_date:String
    let total_tracks:Int
    let artists:[Artist]
    
}
//albums =     {
//    items =         (
//                    {
//            "album_type" = album;
//      
//          
//        
//            type = album;
//            uri = "spotify:album:6y9LbrjY2TpaLvtbE7FTkc";
//        },
//                    {
//            "album_type" = single;
//            artists =                 (
//                                    {
//                    "external_urls" =                         {
//                        spotify = "https://open.spotify.com/artist/6eUKZXaKkcviH0Ku9w2n3V";
//                    };
//                    href = "https://api.spotify.com/v1/artists/6eUKZXaKkcviH0Ku9w2n3V";
//                    id = 6eUKZXaKkcviH0Ku9w2n3V;
//                    name = "Ed Sheeran";
//                    type = artist;
//                    uri = "spotify:artist:6eUKZXaKkcviH0Ku9w2n3V";
//                }
//            );
//            "available_markets" =                 (
//                AD,
//            
//                ZW
//            );
//            "external_urls" =                 {
//                spotify = "https://open.spotify.com/album/5kFCfioZraFsRWpoitQjmx";
//            };
//            href = "https://api.spotify.com/v1/albums/5kFCfioZraFsRWpoitQjmx";
//            id = 5kFCfioZraFsRWpoitQjmx;
//            images =                 (
//                                    {
//                    height = 640;
//                    url = "https://i.scdn.co/image/ab67616d0000b273469407300636945a5eb2d9ed";
//                    width = 640;
//                },
//                                    {
//                    height = 300;
//                    url = "https://i.scdn.co/image/ab67616d00001e02469407300636945a5eb2d9ed";
//                    width = 300;
//                },
//                                    {
//                    height = 64;
//                    url = "https://i.scdn.co/image/ab67616d00004851469407300636945a5eb2d9ed";
//                    width = 64;
//                }
//            );
//            name = Shivers;
//            "release_date" = "2021-09-10";
//            "release_date_precision" = day;
//            "total_tracks" = 1;
//            type = album;
//            uri = "spotify:album:5kFCfioZraFsRWpoitQjmx";
//        }
//    );
//    limit = 2;
//    next = "https://api.spotify.com/v1/browse/new-releases?offset=2&limit=2";
//    offset = 0;
//    previous = "<null>";
//    total = 100;
//};
//}
//

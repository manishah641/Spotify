//
//  albumDetailsResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 18/09/2021.
//

import Foundation
struct AlbumDetailsResponce:Codable {
    let album_type:String
     let artists:[Artist]
    let available_markets:[String]
    let external_urls:[String:String]
    let id:String
    let images:[ApiImage]
    let label:String
    let name:String
    let tracks:TracksResponce
    
    
}
struct TracksResponce:Codable {
    let items:[AudioTrack]
}

//struct Track :Codable{
//    
//    
//    
//    
//}


//{
//artists =                 (
//                {
//"external_urls" =                         {
//    spotify = "https://open.spotify.com/artist/7jVv8c5Fj3E9VhNjxT4snq";
//};
//href = "https://api.spotify.com/v1/artists/7jVv8c5Fj3E9VhNjxT4snq";
//id = 7jVv8c5Fj3E9VhNjxT4snq;
//name = "Lil Nas X";
//type = artist;
//uri = "spotify:artist:7jVv8c5Fj3E9VhNjxT4snq";
//}
//);
//"available_markets" =                 (
//
//);
//"disc_number" = 1;
//"duration_ms" = 137704;
//explicit = 1;
//"external_urls" =                 {
//spotify = "https://open.spotify.com/track/1SC5rEoYDGUK4NfG82494W";
//};
//href = "https://api.spotify.com/v1/tracks/1SC5rEoYDGUK4NfG82494W";
//id = 1SC5rEoYDGUK4NfG82494W;
//"is_local" = 0;
//name = "MONTERO (Call Me By Your Name)";
//"preview_url" = "https://p.scdn.co/mp3-preview/a6e05149543aaa36a3a87ca26665fbd9043f85fd?cid=f6b88cdd24af4acd956cc5a55b262c44";
//"track_number" = 1;
//type = track;
//uri = "spotify:track:1SC5rEoYDGUK4NfG82494W";
//}

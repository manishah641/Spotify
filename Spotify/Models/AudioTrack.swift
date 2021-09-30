//
//  AudioTrack.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
struct AudioTrack:Codable{
    var album:Album?
    let artists:[Artist]
    let available_markets:[String]
    let disc_number:Int
    let duration_ms:Int
    let explicit:Bool
    let external_urls:[String:String]
    let id:String
    let name:String
    let preview_url:String?
}



//{
//    "added_at" = "2021-09-17T04:00:00Z";
//    "added_by" =                 {
//        "external_urls" =                     {
//            spotify = "https://open.spotify.com/user/";
//        };
//        href = "https://api.spotify.com/v1/users/";
//        id = "";
//        type = user;
//        uri = "spotify:user:";
//    };
//    "is_local" = 0;
//    "primary_color" = "<null>";
//    track =                 {
//        album =                     {
//            "album_type" = album;
//            artists =                         (
//                {
//                    "external_urls" =                                 {
//                        spotify = "https://open.spotify.com/artist/7jVv8c5Fj3E9VhNjxT4snq";
//                    };
//                    href = "https://api.spotify.com/v1/artists/7jVv8c5Fj3E9VhNjxT4snq";
//                    id = 7jVv8c5Fj3E9VhNjxT4snq;
//                    name = "Lil Nas X";
//                    type = artist;
//                    uri = "spotify:artist:7jVv8c5Fj3E9VhNjxT4snq";
//                }
//            );
//            "available_markets" =                         (
//                AD,
//                AE,
//                RO,
//                RS,
//                RU,
//                RW,
//
//                ZW
//            );
//            "external_urls" =                         {
//                spotify = "https://open.spotify.com/album/6pOiDiuDQqrmo5DbG0ZubR";
//            };
//            href = "https://api.spotify.com/v1/albums/6pOiDiuDQqrmo5DbG0ZubR";
//            id = 6pOiDiuDQqrmo5DbG0ZubR;
//            images =                         (
//            {
//            height = 640;
//            url = "https://i.scdn.co/image/ab67616d0000b273be82673b5f79d9658ec0a9fd";
//            width = 640;
//            },
//            {
//            height = 300;
//            url = "https://i.scdn.co/image/ab67616d00001e02be82673b5f79d9658ec0a9fd";
//            width = 300;
//            },
//            {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67616d00004851be82673b5f79d9658ec0a9fd";
//            width = 64;
//            }
//            );
//            name = MONTERO;
//            "release_date" = "2021-09-17";
//            "release_date_precision" = day;
//            "total_tracks" = 15;
//            type = album;
//            uri = "spotify:album:6pOiDiuDQqrmo5DbG0ZubR";
//        };
//        artists =                     (
//            {
//                "external_urls" =                             {
//                    spotify = "https://open.spotify.com/artist/7jVv8c5Fj3E9VhNjxT4snq";
//                };
//                href = "https://api.spotify.com/v1/artists/7jVv8c5Fj3E9VhNjxT4snq";
//                id = 7jVv8c5Fj3E9VhNjxT4snq;
//                name = "Lil Nas X";
//                type = artist;
//                uri = "spotify:artist:7jVv8c5Fj3E9VhNjxT4snq";
//            }
//        );
//        "available_markets" =                     (
//            AD,
//            AE,
//            AG,XK,
//            ZA,
//            ZM,
//            ZW
//        );
//        "disc_number" = 1;
//        "duration_ms" = 143901;
//        episode = 0;
//        explicit = 1;
//        "external_ids" =                     {
//            isrc = USSM12105732;
//        };
//        "external_urls" =                     {
//            spotify = "https://open.spotify.com/track/0e8nrvls4Qqv5Rfa2UhqmO";
//        };
//        href = "https://api.spotify.com/v1/tracks/0e8nrvls4Qqv5Rfa2UhqmO";
//        id = 0e8nrvls4Qqv5Rfa2UhqmO;
//        "is_local" = 0;
//        name = "THATS WHAT I WANT";
//        popularity = 47;
//        "preview_url" = "https://p.scdn.co/mp3-preview/75aa4d781c96fe990214d04f4e61efb702bf635c?cid=f6b88cdd24af4acd956cc5a55b262c44";
//        track = 1;
//        "track_number" = 4;
//        type = track;
//        uri = "spotify:track:0e8nrvls4Qqv5Rfa2UhqmO";
//    };
//    "video_thumbnail" =                 {
//        url = "<null>";
//    };
//}
//AlbumDetailsResponce(album_type: "album", artists: [Spotify.Artist(id: "7jVv8c5Fj3E9VhNjxT4snq", name: "Lil Nas X", type: "artist", external_urls: ["spotify": "https://open.spotify.com/artist/7jVv8c5Fj3E9VhNjxT4snq"])], available_markets: ["AD", "AE", "AG", "AL", "AM", "AO", "AR", "AT", "AU", "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BN", "BO", "BR", "BS", "BT", "BW", "BY", "BZ", "CA", "CH", "CI", "CL", "CM", "CO", "CR", "CV", "CW", "CY", "CZ", "DE", "DJ", "DK", "DM", "DO", "DZ", "EC", "EE", "EG", "ES", "FI", "FJ", "FM", "FR", "GA", "GB", "GD", "GE", "GH", "GM", "GN", "GQ", "GR", "GT", "GW", "GY", "HK", "HN", "HR", "HT", "HU", "ID", "IE", "IL", "IN", "IS", "IT", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KR", "KW", "KZ", "LA", "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "MA", "MC", "MD", "ME", "MG", "MH", "MK", "ML", "MN", "MO", "MR", "MT", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NE", "NG", "NI", "NL", "NO", "NP", "NR", "NZ", "OM", "PA", "PE", "PG", "PH", "PK", "PL", "PS", "PT", "PW", "PY", "QA", "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SE", "SG", "SI", "SK", "SL", "SM", "SN", "SR", "ST", "SV", "SZ", "TD", "TG", "TH", "TL", "TN", "TO", "TR", "TT", "TV", "TW", "TZ", "UA", "UG", "US", "UY", "UZ", "VC", "VN", "VU", "WS", "XK", "ZA", "ZM", "ZW"], external_urls: ["spotify": "https://open.spotify.com/album/6pOiDiuDQqrmo5DbG0ZubR"], id: "6pOiDiuDQqrmo5DbG0ZubR", images: [Spotify.ApiImage(url: "https://i.scdn.co/image/ab67616d0000b273be82673b5f79d9658ec0a9fd"), Spotify.ApiImage(url: "https://i.scdn.co/image/ab67616d00001e02be82673b5f79d9658ec0a9fd"), Spotify.ApiImage(url: "https://i.scdn.co/image/ab67616d00004851be82673b5f79d9658ec0a9fd")], label: "Columbia", name: "MONTERO", tracks: Spotify.TracksResponce(items: [Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track(), Spotify.Track()]))


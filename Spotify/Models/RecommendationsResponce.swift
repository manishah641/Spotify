//
//  RecommendationsResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 13/09/2021.
//

import Foundation
struct RecommendationsResponce:Codable {
    let tracks:[AudioTrack]
}


//
//   
//    tracks =     (
//                {
//            
//            artists =             (
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/1UjxAZqzphB1tsMb1aWBj0";
//                    };
//                    href = "https://api.spotify.com/v1/artists/1UjxAZqzphB1tsMb1aWBj0";
//                    id = 1UjxAZqzphB1tsMb1aWBj0;
//                    name = Omega;
//                    type = artist;
//                    uri = "spotify:artist:1UjxAZqzphB1tsMb1aWBj0";
//                },
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/1K00wJTcmA9RZMcEKyB1Jr";
//                    };
//                    href = "https://api.spotify.com/v1/artists/1K00wJTcmA9RZMcEKyB1Jr";
//                    id = 1K00wJTcmA9RZMcEKyB1Jr;
//                    name = "Gocho & Jowell";
//                    type = artist;
//                    uri = "spotify:artist:1K00wJTcmA9RZMcEKyB1Jr";
//                }
//            );
//            "available_markets" =             (
//            );
//            "disc_number" = 1;
//            "duration_ms" = 243546;
//            explicit = 0;
//            "external_ids" =             {
//                isrc = ITF251100005;
//            };
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/track/2hGX7o1gV6cC8s20rJTFsw";
//            };
//            href = "https://api.spotify.com/v1/tracks/2hGX7o1gV6cC8s20rJTFsw";
//            id = 2hGX7o1gV6cC8s20rJTFsw;
//            "is_local" = 0;
//            name = "Dandole Remix";
//            popularity = 0;
//            "preview_url" = "<null>";
//            "track_number" = 2;
//            type = track;
//            uri = "spotify:track:2hGX7o1gV6cC8s20rJTFsw";
//        },
//                {
//            album =             {
//                "album_type" = ALBUM;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/36eSjIksD6fehqxyDUHDA3";
//                        };
//                        href = "https://api.spotify.com/v1/artists/36eSjIksD6fehqxyDUHDA3";
//                        id = 36eSjIksD6fehqxyDUHDA3;
//                        name = "Chris Rock";
//                        type = artist;
//                        uri = "spotify:artist:36eSjIksD6fehqxyDUHDA3";
//                    }
//                );
//                "available_markets" =                 (
//                    AE,
//                    AO,
//                    AR,
//                    BD,
//                    BF,
//                    BH,
//                    BJ,
//                    BO,
//                    CA,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CY,
//                    DJ,
//                    DO,
//                    DZ,
//                    EC,
//                    EG,
//                    GA,
//                    GH,
//                    GM,
//                    GN,
//                    GT,
//                    HN,
//                    IL,
//                    IN,
//                    JO,
//                    KE,
//                    KR,
//                    KW,
//                    LB,
//                    LK,
//                    LR,
//                    LS,
//                    MA,
//                    MG,
//                    ML,
//                    MT,
//                    MU,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    OM,
//                    PA,
//                    PE,
//                    PH,
//                    PY,
//                    QA,
//                    RW,
//                    SA,
//                    SL,
//                    SN,
//                    SV,
//                    TD,
//                    TG,
//                    TH,
//                    TN,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/54pIfwQjTXr3smEVuUksYl";
//                };
//                href = "https://api.spotify.com/v1/albums/54pIfwQjTXr3smEVuUksYl";
//                id = 54pIfwQjTXr3smEVuUksYl;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b27311d81035f84f49c9ccd1314a";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e0211d81035f84f49c9ccd1314a";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d0000485111d81035f84f49c9ccd1314a";
//                        width = 64;
//                    }
//                );
//                name = "Cheese And Crackers - The Greatest Bits";
//                "release_date" = "2007-01-01";
//                "release_date_precision" = day;
//                "total_tracks" = 19;
//                type = album;
//                uri = "spotify:album:54pIfwQjTXr3smEVuUksYl";
//            };
//            artists =             (
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/36eSjIksD6fehqxyDUHDA3";
//                    };
//                    href = "https://api.spotify.com/v1/artists/36eSjIksD6fehqxyDUHDA3";
//                    id = 36eSjIksD6fehqxyDUHDA3;
//                    name = "Chris Rock";
//                    type = artist;
//                    uri = "spotify:artist:36eSjIksD6fehqxyDUHDA3";
//                }
//            );
//            "available_markets" =             (
//                AE,
//                AO,
//                AR,
//                BD,
//                BF,
//                BH,
//                BJ,
//                BO,
//                CA,
//                CI,
//                CL,
//                CM,
//                CO,
//                CY,
//                DJ,
//                DO,
//                DZ,
//                EC,
//                EG,
//                GA,
//                GH,
//                GM,
//                GN,
//                GT,
//                HN,
//                IL,
//                IN,
//                JO,
//                KE,
//                KR,
//                KW,
//                LB,
//                LK,
//                LR,
//                LS,
//                MA,
//                MG,
//                ML,
//                MT,
//                MU,
//                MX,
//                MY,
//                MZ,
//                NA,
//                NE,
//                NG,
//                NI,
//                OM,
//                PA,
//                PE,
//                PH,
//                PY,
//                QA,
//                RW,
//                SA,
//                SL,
//                SN,
//                SV,
//                TD,
//                TG,
//                TH,
//                TN,
//                TW,
//                TZ,
//                UA,
//                UG,
//                US,
//                UY,
//                ZM,
//                ZW
//            );
//            "disc_number" = 1;
//            "duration_ms" = 148200;
//            explicit = 1;
//            "external_ids" =             {
//                isrc = USUM70763145;
//            };
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/track/4YdjR48FooqVt2NHaJJsUx";
//            };
//            href = "https://api.spotify.com/v1/tracks/4YdjR48FooqVt2NHaJJsUx";
//            id = 4YdjR48FooqVt2NHaJJsUx;
//            "is_local" = 0;
//            name = "Olympics - GH Version";
//            popularity = 41;
//            "preview_url" = "<null>";
//            "track_number" = 4;
//            type = track;
//            uri = "spotify:track:4YdjR48FooqVt2NHaJJsUx";
//        }
//    );
//}
//

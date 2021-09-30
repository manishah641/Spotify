//
//  UserProfile.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
struct  UserProfile:Codable {
    
    let country:String
    let display_name:String
    let email:String
    let explicit_content:[String:Bool]
    let external_urls:[String:String]
////    let followers:[String:Codable?]
    let id:String
    let product:String
    let images:[ApiImage]
//    
    
}





//    href = "https://api.spotify.com/v1/users/31mjpkybjwoc6e2bn6rf6uid7hpq";
//    id = 31mjpkybjwoc6e2bn6rf6uid7hpq;
//    images =     (
//                {
//            height = "<null>";
//            url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10209236743209192&height=300&width=300&ext=1633859049&hash=AeRCIQQZ8FtOeZ0yVMs";
//            width = "<null>";
//        }
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:31mjpkybjwoc6e2bn6rf6uid7hpq";
//}

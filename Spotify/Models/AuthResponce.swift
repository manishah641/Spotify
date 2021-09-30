//
//  AuthResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 10/09/2021.
//

import Foundation
struct AuthResponce:Codable {
    let access_token :String
    let expires_in :Int
    let refresh_token :String?
    let scope :String
    let token_type :String
    
    
}

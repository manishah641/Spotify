//
//  SettingsModel.swift
//  Spotify
//
//  Created by Syed Muhammad on 11/09/2021.
//

import Foundation
struct Section {
    let title : String
    let option : [Option]
}
struct  Option {
    let title:String
    let handler:() ->Void
}

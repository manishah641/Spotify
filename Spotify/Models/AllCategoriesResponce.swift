//
//  AllCategoriesResponce.swift
//  Spotify
//
//  Created by Syed Muhammad on 20/09/2021.
//

import Foundation
struct AllCategoriesResponce:Codable {
    let categories:Categories
}
struct Categories:Codable {
    let items:[Category]
}
struct Category:Codable {
    let id:String
    let name:String
    let icons:[ApiImage]
}

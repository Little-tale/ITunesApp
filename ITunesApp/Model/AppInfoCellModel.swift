//
//  AppInfoCellModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation


struct AppInfoCellModel {
    
    let trackName: String
    let sellerName: String
    let artworkUrl60: URL?
    let averageUserRating: String
    let genres: String
    
    
    init(trackName: String, sellerName: String, artworkUrl60: String, averageUserRating: Double, genres: [String]) {
        self.trackName = trackName
        self.sellerName = sellerName
        self.artworkUrl60 = URL(string: artworkUrl60)
        self.averageUserRating = averageUserRating.rounded2
        self.genres = genres.first ?? ""
    }
    
    
}




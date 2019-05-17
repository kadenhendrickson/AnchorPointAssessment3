//
//  Movie.swift
//  AnchorPointAssessment3
//
//  Created by Kaden Hendrickson on 5/17/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation


struct TopLevelJson: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    let title: String
    let rating: Double
    let summary: String
    let imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case imageURL = "poster_path"
    }
}

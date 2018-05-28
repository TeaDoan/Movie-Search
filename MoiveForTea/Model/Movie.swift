//
//  Movie.swift
//  MoiveForTea
//
//  Created by Thao Doan on 5/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

struct Movies: Codable {
    
    let results : [Movie]
    
}
struct Movie: Codable {
    
    let title : String
    let rating : Double
    let posterPath : String?
    let overview  : String
    
    enum CodingKeys : String,CodingKey {
        case title
        case rating = "vote_average"
        case posterPath = "poster_path"
        case overview
        
    }
}


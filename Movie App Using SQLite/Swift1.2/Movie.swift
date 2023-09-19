//
//  Movie.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 5.9.2023.
//

import UIKit
import SQLite3

struct Movie {
    var id: Int 
    var title: String
    var image: String
    var rating: Float
    var releaseYear: Int
    var genre: [String]
}

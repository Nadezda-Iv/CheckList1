//
//  Section.swift
//  CheckList
//
//  Created by MacBook Pro on 05.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    var subtitle: String!

    init (genre: String, movies: [String], expanded: Bool, subtitle: String) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
        self.subtitle = subtitle
    }
}

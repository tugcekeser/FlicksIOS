//
//  Movie.swift
//  Flicks
//
//  Created by Tuze on 3/31/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit

public class Movie:NSObject {
    var posterImageUrl:URL?
    var backdropPathUrl:URL?
    var title:String?
    var overview:String?
    var votes:Int?
    var popularity:Float?
    var genre:[Int]?
    var releaseDate:Date?
    var originalLanguage:String?
    var voteAverage:Float?
    
   /* init(posterImageUrl:URL,backdropPathUrl:URL,title:String, overview: String, votes: Int, popularity: Float, genre:[Int], releaseDate: Date,originalLanguage:String,voteAverage:Float) {
        self.backdropPathUrl=backdropPathUrl
        self.posterImageUrl=posterImageUrl
        self.title=title
        self.overview = overview
        self.votes = votes
        self.popularity = popularity
        self.genre = genre
        self.releaseDate = releaseDate
        self.originalLanguage=originalLanguage
        self.voteAverage=voteAverage
        
    }*/
    override init() {
        
    }
}

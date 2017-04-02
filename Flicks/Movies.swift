//
//  Movies.swift
//  Flicks
//
//  Created by Tuze on 4/1/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit

public class Movies
{
    var movies = [Movie]()
    
    func moviesForItemAtIndexPath(indexPath: NSIndexPath) -> Movie? {
        movies[indexPath.item]
        
    }

}

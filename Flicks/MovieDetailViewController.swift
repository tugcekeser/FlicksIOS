//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Tuze on 4/1/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit


class MovieDetailViewController: UIViewController{

    @IBOutlet weak var movieInfoView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieVotingRate: UILabel!
   
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieOverview: UILabel!
    var movie=Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text=movie.title
        movieOverview.text=movie.overview
        movieInfoView.frame.size.height = movieOverview.frame.size.height + movieTitle.frame.size.height + 25 
        movieInfoView.alpha=1.6
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
            height: movieInfoView.frame.origin.y + movieInfoView.frame.size.height)
        movieVotingRate.text=NSString(format: "%.1f", movie.voteAverage!) as String
       // movieLanguage.text=movie.originalLanguage
       
        setBackgroundImage()
        setTrailerImage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
func setBackgroundImage(){
        let urlImage=movie.posterImageUrl
        
        let imageRequest = URLRequest(url: urlImage!)
        backdropImage.setImageWith(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
            if imageResponse != nil {
                print("image was NOT cached, fade in")
                self.backdropImage.alpha = 0.0
                self.backdropImage.image = image
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    self.backdropImage.alpha = 1.0
                })
            } else {
                print ("image was cached")
                self.backdropImage.image = image
            }
        },
                                          
        failure: { (imageRequest, imageResponse, error) -> Void in
        })
    
    }
    
    func setTrailerImage(){
        let urlImage=movie.backdropPathUrl
        
        let imageRequest = URLRequest(url: urlImage!)
        posterImage.setImageWith(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
            if imageResponse != nil {
                print("image was NOT cached, fade in")
                self.posterImage.alpha = 0.0
                self.posterImage.image = image
              //  self.posterImage.layer.cornerRadius = self.posterImage.frame.size.width / 2;
                self.posterImage.layer.cornerRadius = 10.0;
                self.posterImage.clipsToBounds=true
                self.posterImage.layer.borderWidth = 1.0;
                self.posterImage.layer.borderColor = UIColor.white.cgColor
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    self.posterImage.alpha = 1.0
                })
            } else {
                print ("image was cached")
                self.posterImage.image = image
            }
        },
                                   
        failure: { (imageRequest, imageResponse, error) -> Void in
        })
    }
    
}

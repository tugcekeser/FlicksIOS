//
//  FirstViewController.swift
//  Flicks
//
//  Created by Tuze on 3/31/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit

class NowPlayingController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var nowPlayingCollection: UICollectionView!
   
    var images=["first","second","first","second","first","second","first","second","first","second","first","second"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nowPlayingCollection.delegate=self
        self.nowPlayingCollection.dataSource=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    private struct Storyboard{
        static let CellIdentifier="NowPlayingCollectionViewCell"
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier:Storyboard.CellIdentifier, for: indexPath) as! NowPlayingCollectionViewCell
        cell.posterImageView.image=UIImage(named:images[indexPath.row])
        return cell
    }
}


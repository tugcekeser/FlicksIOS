//
//  FirstViewController.swift
//  Flicks
//
//  Created by Tuze on 3/31/17.
//  Copyright © 2017 Tugce Keser. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class NowPlayingController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nowPlayingTableView: UITableView!
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    var searchController : UISearchController!
    var refreshControl:UIRefreshControl!
    var nowPlayingMovies = [Movie]()
    var filteredNowPlayingMovies=[Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.nowPlayingCollection.delegate=self
        self.nowPlayingCollection.dataSource=self
        self.nowPlayingTableView.dataSource=self
        self.nowPlayingTableView.delegate=self
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 68/255, green: 146/255, blue: 159/255, alpha: 1)
            //UIColor(red: 71/255, green: 66/255, blue: 132/255, alpha: 1)
            //(red: 68/255, green: 146/255, blue: 159/255, alpha: 1)
            //UIColor(red: 164/255, green: 204/255, blue: 203/255, alpha: 1)
        tabBarController?.tabBar.tintColor = UIColor(red: 68/255, green: 146/255, blue: 159/255, alpha: 1)
            //UIColor(red: 141/255, green: 136/255, blue: 230/255, alpha: 1)
            //UIColor(red: 68/255, green: 146/255, blue: 159/255, alpha: 1)
        
        segmentedControl.tintColor = UIColor(red: 164/255, green: 204/255, blue: 203/255, alpha: 1)
        //UIColor(red: 141/255, green: 136/255, blue: 230/255, alpha: 1)
            //UIColor(red: 255/255, green: 214/255, blue: 112/255, alpha: 1)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        nowPlayingCollection.insertSubview(refreshControl, at: 0)
        nowPlayingTableView.insertSubview(refreshControl, at: 0)
        
        fetchNowPlayingMovies(refreshControl)
        setActionBarOnTop()
        
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            nowPlayingTableView.isHidden=false
            nowPlayingCollection.isHidden=true;
        case 1:
            nowPlayingTableView.isHidden=true
            nowPlayingCollection.isHidden=false;
        default:
            break
        }

    }
    
    
    func setActionBarOnTop(){
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchController.searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
       
        if let searchText = searchController.searchBar.text {
            filteredNowPlayingMovies = searchText.isEmpty ? nowPlayingMovies : nowPlayingMovies.filter({ (movie:Movie) -> Bool in
                movie.title?.lowercased().range(of:searchText.lowercased()) != nil
            });
            
            nowPlayingCollection.reloadData()
            nowPlayingTableView.reloadData()
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNowPlayingMovies.count
    }
    
    private struct Storyboard{
        static let CellIdentifier="NowPlayingCollectionViewCell"
        static let CellIdentifierTable="NowPlayingTableViewCell"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNowPlayingMovies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier:Storyboard.CellIdentifierTable, for: indexPath) as! NowPlayingTableViewCell
        let urlImage=filteredNowPlayingMovies[indexPath.item].backdropPathUrl!
        
        let imageRequest = URLRequest(url: urlImage)
        cell.movieImage.setImageWith(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
            if imageResponse != nil {
                print("image was NOT cached, fade in")
                cell.movieImage.alpha = 0.0
                cell.movieImage.image = image
                cell.movieImage.clipsToBounds = true
                cell.movieImage.layer.cornerRadius = 5;
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    cell.movieImage.alpha = 1.0
                })
            } else {
                print ("image was cached")
                cell.movieImage.image = image
            }
        },
                                          
        failure: { (imageRequest, imageResponse, error) -> Void in
        })
        cell.movieTitle.text=filteredNowPlayingMovies[indexPath.item].title!
       
     

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier:Storyboard.CellIdentifier, for: indexPath) as! NowPlayingCollectionViewCell
        let urlImage=filteredNowPlayingMovies[indexPath.item].posterImageUrl!
        
        let imageRequest = URLRequest(url: urlImage)
        cell.posterImageView.setImageWith(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
            if imageResponse != nil {
                print("image was NOT cached, fade in")
                cell.posterImageView.alpha = 0.0
                cell.posterImageView.image = image
                cell.posterImageView.clipsToBounds = true
                cell.posterImageView.layer.cornerRadius = 5;
                UIView.animate(withDuration: 0.7, animations: { () -> Void in
                    cell.posterImageView.alpha = 1.0
                })
            } else {
                print ("image was cached")
                cell.posterImageView.image = image
            }
        },
                                   
        failure: { (imageRequest, imageResponse, error) -> Void in
        })
        cell.movieTitle.text=filteredNowPlayingMovies[indexPath.item].title!
        cell.blurEffect.layer.cornerRadius=5
        cell.blurEffect.clipsToBounds = true
        return cell
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchNowPlayingMovies(refreshControl)
        refreshControl.endRefreshing()
    }
    
    func fetchNowPlayingMovies(_ refreshControl: UIRefreshControl){
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
              
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                
                    if let results = responseDictionary.value(forKeyPath: "results") as? [NSDictionary] {
                        
                    for result in results {
                            
                        //Set the movie
                        let movie=Movie()
                        movie.title=result["original_title"] as? String
                        movie.popularity=result["popularity"] as? Float
                        movie.overview=result["overview"] as? String
                        let posterURL=result["poster_path"] as? String
                        movie.posterImageUrl = URL(string:"http://image.tmdb.org/t/p/w1000"+(posterURL)!)
                        let backdropURL=result["backdrop_path"] as? String
                        movie.backdropPathUrl=URL(string:"http://image.tmdb.org/t/p/w1000"+(backdropURL)!)
                        movie.releaseDate=result["release_date"] as? Date
                        movie.votes=result["vote_count"] as? Int
                        movie.voteAverage=result["vote_average"] as? Float
                        self.nowPlayingMovies.append(movie)
                        
                      }
                        self.filteredNowPlayingMovies=self.nowPlayingMovies
                    
                    }
                }
            }
            self.nowPlayingCollection.reloadData()
            self.nowPlayingTableView.reloadData()

           MBProgressHUD.hide(for: self.view, animated: true)
        });
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let destinationViewController = segue.destination as! MovieDetailViewController
        let cellCollection = sender as! UICollectionViewCell
        let cellTable=sender as! UITableViewCell
        let indexPathCollection = self.nowPlayingCollection!.indexPath(for: cellCollection)
        let indexPathTable=self.nowPlayingTableView!.indexPath(for: cellTable)
        //let movie  = self.filteredNowPlayingMovies[(indexPathCollection?.row)!]
        let movie  = self.filteredNowPlayingMovies[(indexPathTable?.row)!]
        destinationViewController.movie=movie
    
    }
}



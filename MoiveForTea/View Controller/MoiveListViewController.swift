//
//  MoiveListViewController.swift
//  MoiveForTea
//
//  Created by Thao Doan on 5/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class MoiveListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movie : [Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieDetailTableViewCell
        
        let movie = self.movie[indexPath.row]
        cell.movie = movie
        if let path = movie.posterPath {
            MovieControler.getItemIamge(urlAsString: path) { (image) in
                DispatchQueue.main.async {
                    if let image = image , cell.tag == indexPath.row  {
                        cell.imgaes = image
                    }
                }
            }
        }
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let logo = UIImage(named: "food")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit // set imageview's content mode
        self.navigationItem.titleView = imageView
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MoiveListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text?.lowercased() else {return}
        MovieControler.fetchMovie(searchKey: searchTerm) { (movie) in
            guard let fetchMovieItems = movie else {return}
            self.movie = fetchMovieItems
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    
    
    
    
    
    
}

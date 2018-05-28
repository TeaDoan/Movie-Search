//
//  MovieDetailTableViewCell.swift
//  MoiveForTea
//
//  Created by Thao Doan on 5/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movie : Movie? {
        didSet {
            updateView()
        }
        
    }
    
    var imgaes : UIImage? {
        didSet {
            updateView()
        }
    }
    func updateView(){
        
        if let poster = imgaes {
           
                self.movieImage.image = poster

        } else {
            movieImage?.image = UIImage(named:"1122")
        }
          guard let movie = movie else {return}
        
        self.titleLabel.text = "Title : \(movie.title)"
        self.overviewLabel.text = "Overview: \(movie.overview)"
        self.ratingLabel.text = "Ratings:\(movie.rating)"
        }
       
//        if let path = movie.posterPath {
//            guard let image = imgaes else {return}
//        MovieControler.getItemIamge(urlAsString: path) { (image) in
//            guard let image = image else {return}
//            DispatchQueue.main.async {
//                self.imageView?.image = image
//            }
//            }
//          }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
}

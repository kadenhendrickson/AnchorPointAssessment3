//
//  MovieDetailViewController.swift
//  AnchorPointAssessment3
//
//  Created by Kaden Hendrickson on 5/17/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    var movie: Movie?
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {return}
        updateViews(movie: movie)
        MovieController.shared.fetchMovieImageWith(movie: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    func updateViews(movie: Movie) {
        nameLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.rating)"
        summaryTextView.text = movie.summary
    }



}

//
//  MovieDetailTableViewCell.swift
//  AnchorPointAssessment3
//
//  Created by Kaden Hendrickson on 5/17/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    var movie: Movie? {
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReviewRating: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    func updateView() {
        guard let movie = movie else {return}
        movieNameLabel.text = movie.title
        movieReviewRating.text = "Rating: \(movie.rating)"
        summaryTextView.text = movie.summary
    }
}

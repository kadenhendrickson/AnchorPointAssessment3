//
//  MovieListTableViewController.swift
//  AnchorPointAssessment3
//
//  Created by Kaden Hendrickson on 5/17/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    
    var movies: [Movie] = [] {
        didSet {
         
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieDetailTableViewCell
        
        let movie = movies[indexPath.row]
        cell?.movie = movie
        MovieController.shared.fetchMovieImageWith(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell?.movieImage.image = image
            }
        }
    
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? MovieDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let movie = movies[indexPath.row]
            destinationVC.movie = movie
        }
        
    }
    
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        MovieController.shared.fetchMovieWith(searchTerm: searchTerm) { (movie) in
            self.movies = movie
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

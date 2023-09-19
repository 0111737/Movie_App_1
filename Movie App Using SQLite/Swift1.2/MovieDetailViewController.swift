//
//  MovieDetailViewController.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 5.9.2023.
//
import UIKit


class MovieDetailViewController: UIViewController {
    var movie: Movie?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLabel.text = movie.title
            imageView.image = UIImage(named: movie.image)
            ratingLabel.text = "\(movie.rating)"
            releaseYearLabel.text = "\(movie.releaseYear)"
            genreLabel.text = "\(movie.genre.joined(separator: ", "))"
        }
    }
}

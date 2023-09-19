//
//  AddMovieViewController.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 6.9.2023.
//
import UIKit

protocol AddMovieDelegate: AnyObject {
    func didAddMovie(_ movie: Movie)
}

class AddMovieViewController: UIViewController {

    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var releaseYearTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var imageNameTextField: UITextField!

    weak var delegate: AddMovieDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        if let title = titleTextField.text,
            let ratingText = ratingTextField.text,
            let rating = Float(ratingText),
            let releaseYearText = releaseYearTextField.text,
            let releaseYear = Int(releaseYearText),
            let genre = genreTextField.text?.components(separatedBy: ","),
            let imageName = imageNameTextField.text {

            let newMovie = Movie(id: 0, title: title, image: imageName, rating: rating, releaseYear: releaseYear, genre: genre)

            delegate?.didAddMovie(newMovie)
            navigationController?.popViewController(animated: true)
        }
    }
}

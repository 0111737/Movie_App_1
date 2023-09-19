//
//  MovieTableViewController.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 5.9.2023.

import UIKit

class MovieTableViewController: UITableViewController, AddMovieDelegate {
    
    var movies: [Movie] = []
    var databaseManager = DatabaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load movies from the database when the view loads
        movies = databaseManager.fetchMovies()    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetail", let destinationVC = segue.destination as? MovieDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedMovie = movies[indexPath.row]
                destinationVC.movie = selectedMovie
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movie List"
    }
    
    @IBAction func didAddMoviePressed(_ sender: UIBarButtonItem) {
        if let addMovieVC = storyboard?.instantiateViewController(withIdentifier: "AddMovieViewController") as? AddMovieViewController {
            addMovieVC.delegate = self
            navigationController?.pushViewController(addMovieVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let movieToDelete = movies[indexPath.row]

               // Remove the item from the data source (movies array)
               movies.remove(at: indexPath.row)

               // Delete the record from the SQLite database
               databaseManager.deleteMovie(id: movieToDelete.id)

               // Delete the row from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    
    
    func didAddMovie(_ movie: Movie) {
           // Add the new movie to the array and database
           movies.append(movie)
           databaseManager.insertMovie(movie)

           // Reload the table view to reflect the changes
           tableView.reloadData()
       }
}

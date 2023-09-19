//
//  DatabaseManager.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 10.9.2023.
////
import UIKit
import SQLite3


class DatabaseManager {

    var db: OpaquePointer?

    init() {
        // Open or create the SQLite database
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Database1.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
        
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Movies (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                image TEXT,
                rating REAL,
                releaseYear INTEGER,
                genre TEXT
            );
        """
        if executeQuery(createTableQuery) {
            print("Movies table created")
        }
    }

    func executeQuery(_ query: String) -> Bool {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        return false
    }

    func insertMovie(_ movie: Movie) {
        let insertQuery = """
            INSERT INTO Movies (title, image, rating, releaseYear, genre)
            VALUES (?, ?, ?, ?, ?);
        """
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (movie.image as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 3, Double(movie.rating))
            sqlite3_bind_int(statement, 4, Int32(movie.releaseYear))
            sqlite3_bind_text(statement, 5, (movie.genre.joined(separator: ", ") as NSString).utf8String, -1, nil)

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Movie inserted successfully")
            }
            sqlite3_finalize(statement)
        }
    }

    func fetchMovies() -> [Movie] {
        var movies: [Movie] = []
        let query = "SELECT * FROM Movies;"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let title = String(cString: sqlite3_column_text(statement, 1))
                let image = String(cString: sqlite3_column_text(statement, 2))
                let rating = Float(sqlite3_column_double(statement, 3))
                let releaseYear = Int(sqlite3_column_int(statement, 4))
                let genreString = String(cString: sqlite3_column_text(statement, 5))
                let genre = genreString.components(separatedBy: ", ")

                let movie = Movie(id: id, title: title, image: image, rating: rating, releaseYear: releaseYear, genre: genre)
                movies.append(movie)
            }
        }
        sqlite3_finalize(statement)
        return movies
    }
    func deleteMovie(id: Int) {
        let deleteQuery = "DELETE FROM Movies WHERE id = ?;"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Movie deleted successfully")
            }
            sqlite3_finalize(statement)
        }
    }
}

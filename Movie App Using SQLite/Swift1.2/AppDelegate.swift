//
//  AppDelegate.swift
//  Swift1.2
//
//  Created by Shimaa Alaa on 5.9.2023.
//
import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var db: OpaquePointer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let dbPathURL = URL(fileURLWithPath: dbPath).appendingPathComponent("movies.sqlite3")
//
//        if sqlite3_open(dbPathURL.path, &db) != SQLITE_OK {
//            print("Error opening database")
//        }
//
//        let createTableSQL = """
//            CREATE TABLE IF NOT EXISTS movies (
//                id INTEGER PRIMARY KEY AUTOINCREMENT,
//                title TEXT,
//                image TEXT,
//                rating REAL,
//                releaseYear INTEGER,
//                genre TEXT
//            );
//        """
//
//        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db))
//            print("Error creating table: \(errmsg)")
//        }
//
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

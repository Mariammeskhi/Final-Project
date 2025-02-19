//
//  SongInfoViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit
import CoreData

class SongInfoViewController: UIViewController {
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var songAuthor: UILabel!
    
    @IBOutlet weak var addToFavsButton: UIButton!
    
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let labels = [songTitle,songAuthor]
           for label in labels {
               label?.layer.cornerRadius = 15
               label?.layer.borderWidth = 1
               label?.layer.borderColor = UIColor.lightGray.cgColor
               label?.clipsToBounds = true
           }
        
        addToFavsButton.layer.cornerRadius = 38
        
        populateData()
    }
    
    private func populateData() {
            guard let song = song else { return }
            
            songTitle.text = song.title
            songAuthor.text = "Artist: \(song.album.coverMedium)"
            
            if let imageUrl = URL(string: song.album.coverMedium) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.songImage.image = image
                        }
                    }
                }
            }
        }
    
    @IBAction func didTapAddToFavs(_ sender: Any) {
        
        guard let song = song else { return }
                
                saveToFavorites(song: song)
    }
    
    private func saveToFavorites(song: Song) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            let favorite = NSEntityDescription.insertNewObject(forEntityName: "FavoriteSong", into: context)
            favorite.setValue(song.title, forKey: "title")
            favorite.setValue(song.album.coverMedium, forKey: "albumCover")
            
            do {
                try context.save()
                showAlert(title: "Success", message: "Song added to favorites!")
            } catch {
                showAlert(title: "Error", message: "Failed to add song to favorites.")
            }
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }

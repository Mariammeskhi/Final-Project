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
    
    
    @IBOutlet weak var addToFavsButton: UIButton!
    
    var song: SongDTO?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            populateData()
        }
        
        private func configureUI() {
            songTitle.layer.cornerRadius = 15
            songTitle.layer.borderWidth = 1
            songTitle.layer.borderColor = UIColor.lightGray.cgColor
            songTitle.clipsToBounds = true
            addToFavsButton.layer.cornerRadius = 20
        }
        
        private func populateData() {
            guard let song = song else { return }
            songTitle.text = song.name
            
            if let imageUrl = URL(string: song.album.cover) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.songImage.image = image
                        }
                    }
                }
            }
        }
        
        @IBAction func didTapAddToFavs(_ sender: UIButton) {
            guard let song = song else { return }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            saveToFavorites(song: song, context: context, navigationController: self.navigationController)
        }
        
        func saveToFavorites(song: SongDTO, context: NSManagedObjectContext, navigationController: UINavigationController?) {
            let fetchRequest = NSFetchRequest<Song>(entityName: "Song")
            fetchRequest.predicate = NSPredicate(format: "name == %@", song.name)

            do {
                let results = try context.fetch(fetchRequest)
                if let existingSong = results.first {
                    existingSong.isFavorite = true
                } else {
                    let newSong = Song(context: context)
                    newSong.id = UUID()
                    newSong.name = song.name
                    newSong.albumCover = song.album.cover
                    newSong.isFavorite = true
                }
                try context.save()

               
                showAlert(title: "Success", message: "Added to Favorites!") { _ in
                    if let favoritesVC = UIStoryboard(name: "Favorites", bundle: nil)
                        .instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController {
                        navigationController?.pushViewController(favoritesVC, animated: true)
                    }
                }
            } catch {
                print("Failed to save favorite: \(error)")
            }
        }

        private func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
            present(alert, animated: true)
        }
    }

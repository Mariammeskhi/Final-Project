//
//  FavSongViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import UIKit

import CoreData

class FavSongViewController: UIViewController {
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var removeFromFavorites: UIButton!
    
    var managedObjectContext: NSManagedObjectContext?
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        configureUI()
    }
    
    
    private func configureUI() {
        songTitle.layer.cornerRadius = 15
        songTitle.layer.borderWidth = 1
        songTitle.layer.borderColor = UIColor.lightGray.cgColor
        songTitle.clipsToBounds = true
        removeFromFavorites.layer.cornerRadius = 20
    }
    
    private func populateData() {
        guard let song = song else { return }
        songTitle.text = song.name
        
        if let imageUrl = song.albumCover, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.songImage.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func didTapRemoveFromFavorites(_ sender: UIButton) {
        removeFromCoreData()
    }
    
    private func removeFromCoreData() {
        guard let song = song, let songName = song.name else { return }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<Song>(entityName: "Song")
            fetchRequest.predicate = NSPredicate(format: "name == %@", songName)

            do {
                let results = try context.fetch(fetchRequest)
                if let songToDelete = results.first {
                    context.delete(songToDelete)
                    try context.save()
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name("FavoriteSongRemoved"), object: songName)
                        self.navigationController?.popViewController(animated: true) 
                    }
                }
            } catch {
                print("Failed to remove favorite: \(error)")
            }
        }
    
    private func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
                present(alert, animated: true)
            }
    }

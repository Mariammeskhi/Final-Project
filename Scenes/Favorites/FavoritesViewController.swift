//
//  FavoritesViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var favoriteSongs: [Song] = []
       var managedObjectContext: NSManagedObjectContext?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           configureCollectionView()
           fetchFavorites()
           
           NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteSongRemoved(_:)), name: NSNotification.Name("FavoriteSongRemoved"), object: nil)
          
       }
       
       private func configureCollectionView() {
           favoritesCollectionView.delegate = self
           favoritesCollectionView.dataSource = self
           
           let nib = UINib(nibName: "FavoritesCollectionViewCell", bundle: nil)
           favoritesCollectionView.register(nib, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
       }
       
       private func fetchFavorites() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let context = appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<Song>(entityName: "Song")
           fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
           
           do {
               favoriteSongs = try context.fetch(fetchRequest)
               favoritesCollectionView.reloadData()
           } catch {
               print("Failed to fetch favorites: \(error)")
           }
       }
    
    @objc private func handleFavoriteSongRemoved(_ notification: Notification) {
        guard let songName = notification.object as? String else { return }

        if let index = favoriteSongs.firstIndex(where: { ($0.value(forKey: "name") as? String) == songName }) {
            favoriteSongs.remove(at: index)

            
            favoritesCollectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
    }
   }



   extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return favoriteSongs.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell else {
               return UICollectionViewCell()
           }
           cell.configure(with: favoriteSongs[indexPath.row])
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let storyboard = UIStoryboard(name: "FavSong", bundle: nil)
           if let favSongVC = storyboard.instantiateViewController(withIdentifier: "FavSongViewController") as? FavSongViewController {
               favSongVC.song = favoriteSongs[indexPath.row]
               favSongVC.managedObjectContext = self.managedObjectContext
               navigationController?.pushViewController(favSongVC, animated: true)
           }
       }
   }

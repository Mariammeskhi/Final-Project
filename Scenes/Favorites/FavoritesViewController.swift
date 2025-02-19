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
    
    var favoriteSongs: [NSManagedObject] = []
    
    var managedObjectContext: NSManagedObjectContext?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
                fetchFavorites()
    }
    
    private func configureCollectionView() {
           favoritesCollectionView.delegate = self
           favoritesCollectionView.dataSource = self
       }

       private func fetchFavorites() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let context = appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteSong")
           
           do {
               favoriteSongs = try context.fetch(fetchRequest)
               favoritesCollectionView.reloadData()
           } catch {
               print("Failed to fetch favorites: \(error)")
           }
       }
   }

   // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
   extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return favoriteSongs.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell else {
               return UICollectionViewCell()
           }
           
           let favorite = favoriteSongs[indexPath.row]
           if let albumCover = favorite.value(forKey: "albumCover") as? String,
              let imageUrl = URL(string: albumCover) {
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           cell.songImage.image = image
                       }
                   }
               }
           }
           
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let storyboard = UIStoryboard(name: "FavSong", bundle: nil)
           if let favSongVC = storyboard.instantiateViewController(withIdentifier: "FavSongViewController") as? FavSongViewController {
               let favorite = favoriteSongs[indexPath.row]
               
               favSongVC.songTitleText = favorite.value(forKey: "title") as? String
               favSongVC.songAuthorText = favorite.value(forKey: "author") as? String
               favSongVC.songImageURL = favorite.value(forKey: "albumCover") as? String
               
               favSongVC.managedObjectContext = self.managedObjectContext
               navigationController?.pushViewController(favSongVC, animated: true)
           }
       }
   }

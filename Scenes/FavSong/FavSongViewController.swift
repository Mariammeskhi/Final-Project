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
    
    @IBOutlet weak var songAuthor: UILabel!
    
    
    @IBOutlet weak var removeFromFavorites: UIButton!
    
        var songTitleText: String?
        var songAuthorText: String?
        var songImageURL: String?
        var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let labels = [songTitle,songAuthor]
           for label in labels {
               label?.layer.cornerRadius = 15
               label?.layer.borderWidth = 1
               label?.layer.borderColor = UIColor.lightGray.cgColor
               label?.clipsToBounds = true
           }
        
        removeFromFavorites.layer.cornerRadius = 38
        
        populateData()
    }
    
    private func populateData() {
           songTitle.text = songTitleText
           songAuthor.text = songAuthorText

           if let imageURL = songImageURL, let url = URL(string: imageURL) {
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self.songImage.image = image
                       }
                   }
               }
           }
       }


    @IBAction func didTapRemoveFromFavorites(_ sender: Any) {
        removeFromCoreData()
    }
    
    private func removeFromCoreData() {
          guard let context = managedObjectContext else { return }
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteSong")
          fetchRequest.predicate = NSPredicate(format: "title == %@", songTitleText ?? "")

          do {
              let results = try context.fetch(fetchRequest)
              if let objectToDelete = results.first {
                  context.delete(objectToDelete)
                  try context.save()
                  navigationController?.popViewController(animated: true)
              }
          } catch {
              print("Failed to delete the song from favorites: \(error)")
          }
      }
  }

//
//  FavSongViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 16.02.25.
//

import UIKit

class FavSongViewController: UIViewController {
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var songAuthor: UILabel!
    
    
    @IBOutlet weak var removeFromFavorites: UIButton!
    
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
    }
    

    @IBAction func didTapRemoveFromFavorites(_ sender: Any) {
    }
    
}

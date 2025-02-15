//
//  SongInfoViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit

class SongInfoViewController: UIViewController {
    
    
    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var songAuthor: UILabel!
    
    @IBOutlet weak var addToFavsButton: UIButton!
    
    
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
        
    }
    
    @IBAction func didTapAddToFavs(_ sender: Any) {
    }
    
}

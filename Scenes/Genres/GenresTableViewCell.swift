//
//  GenresTableViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 13.02.25.
//

import UIKit

class GenresTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var genresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genresLabel.layer.cornerRadius = 15
            genresLabel.clipsToBounds = true
            genresLabel.textAlignment = .center
            genresLabel.textColor = .white
            genresLabel.backgroundColor = UIColor(red: 109/255, green: 96/255, blue: 220/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
       
       func configure(with genre: Genre) {
           genresLabel.text = genre.name
       }
   }

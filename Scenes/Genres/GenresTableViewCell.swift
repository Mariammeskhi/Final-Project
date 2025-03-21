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
        
        //genresLabel.layer.cornerRadius = 15
            genresLabel.clipsToBounds = true
            genresLabel.textAlignment = .center
            genresLabel.textColor = .white
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
       
       func configure(with genre: Genre) {
           genresLabel.text = genre.name
       }
   }

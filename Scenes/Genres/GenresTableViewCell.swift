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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

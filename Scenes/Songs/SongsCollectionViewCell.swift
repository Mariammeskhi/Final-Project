//
//  SongsCollectionViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit
import Kingfisher

class SongsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImage: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           songImage.contentMode = .scaleAspectFill
           songImage.clipsToBounds = true
           layer.cornerRadius = 8
           layer.masksToBounds = true
       }
    
    func configure(with song: SongDTO){
        songImage.kf.setImage(with: URL(string: song.album.cover))
    }
   }

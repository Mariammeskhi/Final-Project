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

       /*func configure(with song: Song) {
           if let albumCover = song.albumCover, let imageUrl = URL(string: albumCover) {
               DispatchQueue.global().async {
                   if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self.songImage.image = image
                       }
                   }
               }
           } else {
               songImage.image = UIImage(named: "placeholder")
           }
       }*/
    
    func configure(with song: SongDTO){
        songImage.kf.setImage(with: URL(string: song.picture))
    }
   }

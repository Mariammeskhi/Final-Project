//
//  SongsCollectionViewCell.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var songImage: UIImageView!
    
    
    @IBOutlet weak var songName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with song: Song) {
            songName.text = song.title
            if let imageUrl = URL(string: song.album.coverMedium) {
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.songImage.image = image
                        }
                    }
                }
            }
        }
    }

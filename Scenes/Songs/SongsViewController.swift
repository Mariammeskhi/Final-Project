//
//  SongsViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 15.02.25.
//

import UIKit

class SongsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var genreId: Int?
        private var songs: [Song] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            fetchSongs()
        }
        
        private func setupCollectionView() {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            let nib = UINib(nibName: "SongsCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "SongsCollectionViewCell")
        }
        
        private func fetchSongs() {
            guard let genreId = genreId else { return }
            let urlString = "https://api.deezer.com/genre/\(genreId)/artists"
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching songs: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let response = try JSONDecoder().decode(SongsResponse.self, from: data)
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        let context = appDelegate.persistentContainer.viewContext
                        
                        self.songs = response.data.map { songDTO in
                            let song = Song(context: context)
                            song.name = songDTO.title
                            song.albumCover = songDTO.album.coverMedium ?? ""
                            return song
                        }
                        
                        do {
                            try context.save()
                        } catch {
                            print("Error saving songs: \(error)")
                        }
                        
                        self.collectionView.reloadData()
                    }
                } catch {
                    print("Error decoding songs: \(error)")
                }
            }.resume()
        }
    }

    extension SongsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return songs.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongsCollectionViewCell", for: indexPath) as? SongsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let song = songs[indexPath.row]
            cell.configure(with: song)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedSong = songs[indexPath.row]
            print("Selected song: \(selectedSong.name ?? "Unknown")")
        }
    }

    extension SongsViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let spacing: CGFloat = 10
            let width = (collectionView.frame.width - (3 * spacing)) / 2
            return CGSize(width: width, height: width)
        }
    }

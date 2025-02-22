//
//  GenresViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 13.02.25.
//

import UIKit

class GenresViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var genres = [Genre]()
    var filteredGenres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
                tableView.dataSource = self
                searchBar.delegate = self
        
        
        
        let nib = UINib(nibName: "GenresTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "GenresTableViewCell")
                
                fetchGenres()

    }
    
    private func fetchGenres() {
           let urlString = "https://api.deezer.com/genre" 
           guard let url = URL(string: urlString) else { return }
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let error = error {
                   print("Error fetching genres: \(error.localizedDescription)")
                   return
               }
               
               guard let data = data else { return }
               
               do {
                   let decoder = JSONDecoder()
                   let genresResponse = try decoder.decode(GenresResponse.self, from: data)
                   self.genres = genresResponse.data
                   self.filteredGenres = self.genres
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               } catch {
                   print("Error decoding genres: \(error.localizedDescription)")
               }
           }.resume()
       }
   }

   extension GenresViewController: UITableViewDataSource, UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return filteredGenres.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "GenresTableViewCell", for: indexPath)
           let genre = filteredGenres[indexPath.row]
           cell.textLabel?.text = genre.name
           return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedGenre = filteredGenres[indexPath.row]
           let storyboard = UIStoryboard(name: "Songs", bundle: nil)
           if let songsVC = storyboard.instantiateViewController(withIdentifier: "SongsViewController") as? SongsViewController {
               songsVC.genreId = selectedGenre.id
               navigationController?.pushViewController(songsVC, animated: true)
           }
       }
   }

   extension GenresViewController: UISearchBarDelegate {
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           filteredGenres = searchText.isEmpty ? genres : genres.filter { $0.name.lowercased().contains(searchText.lowercased()) }
           tableView.reloadData()
       }
   }

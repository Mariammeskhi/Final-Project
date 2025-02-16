//
//  LogInViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 13.02.25.
//

import UIKit



class LogInViewController: UIViewController {

    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fields = [ userNameField, passwordField]
           for field in fields {
               field?.layer.cornerRadius = 15
               field?.layer.borderWidth = 1
               field?.layer.borderColor = UIColor.lightGray.cgColor
               field?.clipsToBounds = true
           }
        
        logInButton.layer.cornerRadius = 38
        
    }
    
    @IBAction func didTapLogIn(_ sender: UIButton) {
            guard let userName = userNameField.text, !userName.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                showAlert(title: "შეცდომა", message: "გთხოვთ შეავსოთ ყველა ველი")
                return
            }
            
            if authenticateUser(userName: userName, password: password) {
                navigateToGenres()
            } else {
                showAlert(title: "შეცდომა", message: "იუზერნეიმი ან პაროლი არასწორია")
            }
        }
        
        private func authenticateUser(userName: String, password: String) -> Bool {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "userName == %@ AND password == %@", userName, password)
            
            do {
                let users = try context.fetch(fetchRequest)
                return !users.isEmpty
            } catch {
                print("მონაცემების წამოღება ვერ მოხერხდა: \(error.localizedDescription)")
                return false
            }
        }
        
        private func navigateToGenres() {
            let storyboard = UIStoryboard(name: "Genres", bundle: nil)
            if let genresVC = storyboard.instantiateViewController(withIdentifier: "GenresViewController") as? GenresViewController {
                navigationController?.pushViewController(genresVC, animated: true)
            }
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}

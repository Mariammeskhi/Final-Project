//
//  RegistrationViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 12.02.25.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fields = [nameField, userNameField, emailField, passwordField]
           for field in fields {
               field?.layer.cornerRadius = 15
               field?.layer.borderWidth = 1
               field?.layer.borderColor = UIColor.lightGray.cgColor
               field?.clipsToBounds = true
           }
        
        registerButton.layer.cornerRadius = 38
    }

    
    @IBAction func didTapRegister(_ sender: UIButton) {
            guard let name = nameField.text, !name.isEmpty,
                  let userName = userNameField.text, !userName.isEmpty,
                  let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else {
                showAlert(title: "შეცდომა", message: "გთხოვთ შეავსოთ ყველა ველი")
                return
            }
            
            if isUserNameTaken(userName: userName) {
                showAlert(title: "შეცდომა", message: "მომხმარებლის სახელი უკვე გამოყენებულია")
                return
            }
            
            saveUser(name: name, userName: userName, email: email, password: password)
            navigateToLogin()
        }
        
        private func saveUser(name: String, userName: String, email: String, password: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
            let user = NSManagedObject(entity: entity, insertInto: context)
            
            user.setValue(name, forKey: "name")
            user.setValue(userName, forKey: "userName")
            user.setValue(email, forKey: "email")
            user.setValue(password, forKey: "password")
            
            do {
                try context.save()
            } catch {
                print("მონაცემების შენახვა ვერ მოხერხდა: \(error.localizedDescription)")
            }
        }
        
        private func isUserNameTaken(userName: String) -> Bool {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "userName == %@", userName)
            
            do {
                let users = try context.fetch(fetchRequest)
                return !users.isEmpty
            } catch {
                print("მონაცემების წამოღება ვერ მოხერხდა: \(error.localizedDescription)")
                return false
            }
        }
        
        private func navigateToLogin() {
            let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
                navigationController?.pushViewController(loginVC, animated: true)
            }
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}


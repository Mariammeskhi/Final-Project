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
    }

}

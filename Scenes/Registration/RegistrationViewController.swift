//
//  RegistrationViewController.swift
//  Final Project
//
//  Created by mariam meskhi on 12.02.25.
//

import UIKit

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
    }
    
}


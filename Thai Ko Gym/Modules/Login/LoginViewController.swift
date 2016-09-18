//
//  LoginViewController.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - View Model
    
    private let viewModel = LoginViewModel()
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func authenticate(sender: AnyObject) {
        print("🐜", "Start authenticating")
        viewModel.authenticate(email: emailField.text, password: passwordField.text) { success in
            
        }
    }
    
}

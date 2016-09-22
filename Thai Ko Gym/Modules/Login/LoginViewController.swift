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
    
    // MARK: - Navigation
    
    var flowNavigationController: FlowNavigationViewController? {
        return self.navigationController as? FlowNavigationViewController
    }
    
    // MARK: - Actions
    
    @IBAction func authenticate(sender: AnyObject) {
        print("🐜", "Start authenticating")
        viewModel.authenticate(email: emailField.text, password: passwordField.text) { result in
            guard result.succeeded else {
                return
            }
            
            self.setEditing(false, animated: true)
            self.flowNavigationController?.pushToMembersViewController()
        }
    }
    
}

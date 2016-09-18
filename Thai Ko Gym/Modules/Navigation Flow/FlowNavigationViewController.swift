//
//  FlowNavigationViewController.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class FlowNavigationViewController: UINavigationController {
    
    // MARK: - View Model
    
    private var viewModel = FlowNavigationViewModel()

    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        determineRootViewController()
    }
    
    // MARK: - Root View Controller
    
    private func determineRootViewController() {
        var controllers = [loginViewController]
        if viewModel.authenticated {
            controllers.append(membersViewController)
        }
        self.viewControllers = controllers
    }
    
    private var loginViewController: UIViewController {
        return viewController(with: "Login")
    }
    
    private var membersViewController: UIViewController {
        return viewController(with: "Members")
    }
    
    private func viewController(with name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
}

//
//  MembersViewController.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {

    // MARK: - View Model

    private let viewModel = MembersViewModel()

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(sender:)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        print("🚃 Start fetching members")
        viewModel.fetchMembers { result in
            print("🚃 Fetched members", result.objects?.count)
        }
    }

    // MARK: - Actions

    func logout(sender: AnyObject) {
        let controller = UIAlertController(title: "Logout", message: "Are you sure you want to log out? You will lose all your current data on the device.", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            self.viewModel.logout()
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(controller, animated: true, completion: nil)
    }

}

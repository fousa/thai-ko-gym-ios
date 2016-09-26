//
//  ProgressHUD.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 26/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import MBProgressHUD

class ProgressHUD {

    static func present(on view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }

    static func dismiss(on view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }

}

//
//  KeyboardLayoutConstraint.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 18/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    // MARK: - Observers
    
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: - Internal Values
    
    private var initialConstant: CGFloat!
    
    // MARK: - Flow
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialConstant = constant
        
        print("👔", "Observe the keyboard appearance")
        keyboardWillShowObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { notification in
            self.handleKeyboardAppearance(presenting: true, userInfo: notification.userInfo)
        }
        keyboardWillHideObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { notification in
            self.handleKeyboardAppearance(presenting: false, userInfo: notification.userInfo)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(keyboardWillShowObserver)
        NotificationCenter.default.removeObserver(keyboardWillHideObserver)
    }
    
    // MARK: - Update constraint
    
    private func handleKeyboardAppearance(presenting: Bool, userInfo: [AnyHashable: Any]?) {
        print("🐜", "Handle keyboard appearance", presenting)
        
        let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        guard let bounds = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            print("💀", "Keyboard bounds not found")
            return
        }
        
        constant += initialConstant + bounds.height - constant
        UIView.animate(withDuration: duration ?? 0.0, delay: 0.0, options: .curveEaseIn, animations: {
            (self.firstItem as? UIView)?.superview?.layoutIfNeeded()
        }, completion: nil)
    }
    
}

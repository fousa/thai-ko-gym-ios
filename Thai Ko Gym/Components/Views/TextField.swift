//
//  TextField.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 26/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {

    // MARK: - Designables

    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var borderColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Drawing

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(borderColor.cgColor)
        let rect = CGRect(x: 0, y: rect.height - borderWidth, width: rect.width, height: borderWidth)
        context?.fill(rect)
    }

}

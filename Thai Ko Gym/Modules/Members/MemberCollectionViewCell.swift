//
//  MemberCollectionViewCell.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 22/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

protocol MemberPresentation {
    var name: String { get }
}

class MemberCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var selectionImageView: UIImageView!

    // MARK: - Configure

    func configure(presentation: MemberPresentation) {
        nameLabel.text = presentation.name.uppercased()

        updateSelection()
    }

    // MARK: - Selection

    override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
            updateSelection()
        }
    }

    private func updateSelection() {
        selectionImageView.isHidden = !isSelected

        if isSelected {
            nameLabel.textColor = UIColor(red:0.24, green:0.77, blue:0.82, alpha:1.00)
        } else {
            nameLabel.textColor = UIColor(red:0.21, green:0.25, blue:0.31, alpha:1.00)
        }
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        // Handle traitCollection changes.
        setNeedsDisplay()
    }

    // MARK: - Drawing

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()

        if isSelected {
            context?.setFillColor(UIColor(red:0.24, green:0.77, blue:0.82, alpha:0.30).cgColor)
        } else {
            context?.setFillColor(UIColor(red:0.87, green:0.89, blue:0.93, alpha:0.30).cgColor)
        }
        context?.fill(rect)
    }

}

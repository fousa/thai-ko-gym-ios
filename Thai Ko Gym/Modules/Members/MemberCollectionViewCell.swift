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

    // MARK: - Configure

    func configure(presentation: MemberPresentation) {
        nameLabel.text = presentation.name
    }

}

//
//  TextCell.swift
//  Demo
//
//  Created by suguru-kishimoto on 2017/10/04.
//  Copyright © 2017年 Suguru Kishimoto. All rights reserved.
//

import UIKit

final class TextCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with news: (title: String, description: String)) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }
}

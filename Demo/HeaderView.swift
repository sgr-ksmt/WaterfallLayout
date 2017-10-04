//
//  HeaderView.swift
//  Demo
//
//  Created by suguru-kishimoto on 2017/10/04.
//  Copyright © 2017年 Suguru Kishimoto. All rights reserved.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with title: String) {
        titleLabel.text = title
    }
}

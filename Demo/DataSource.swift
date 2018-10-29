//
//  DataSource.swift
//  Demo
//
//  Created by suguru-kishimoto on 2017/10/03.
//  Copyright © 2017年 Suguru Kishimoto. All rights reserved.
//

import UIKit

struct SampleResponse: Decodable {
    struct Item: Decodable {
        var color: UIColor
        var size: CGSize

        enum CodingKeys: String, CodingKey {
            case color
            case size
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.size = try container.decode(CGSize.self, forKey: .size)
            let hex = try container.decode(String.self, forKey: .color)
            guard let color = UIColor(hex: hex) else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            self.color = color
        }
    }

    struct News: Decodable {
        var title: String
        var description: String
    }

    enum Content: String, Decodable {
        case topicItem = "topic_item"
        case items
        case news
    }

    enum CodingKeys: String, CodingKey {
        case topicItem = "topic_item"
        case items
        case news
        case contents
    }

    var topicItem: Item
    var items: [Item]
    var news: [News]
    var contents: [Content]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.topicItem = try container.decode(Item.self, forKey: .topicItem)
        self.items = try container.decode([Item].self, forKey: .items)
        self.news = try container.decode([News].self, forKey: .news)
        self.contents = try container.decode([Content].self, forKey: .contents)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexCode: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (hexCode.hasPrefix("#")) {
            hexCode.remove(at: hexCode.startIndex)
        }

        if(hexCode.count != 6) {
            return nil
        }

        var rgbValue: UInt32 = 0
        Scanner(string: hexCode).scanHexInt32(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}

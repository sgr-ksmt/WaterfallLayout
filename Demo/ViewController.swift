//
//  ViewController.swift
//  Demo
//
//  Created by suguru-kishimoto on 2017/10/03.
//  Copyright © 2017年 Suguru Kishimoto. All rights reserved.
//

import UIKit
import WaterfallLayout

class ViewController: UIViewController {

    lazy var layout = WaterfallLayout()
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            layout.delegate = self
            layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            layout.minimumLineSpacing = 8.0
            layout.minimumInteritemSpacing = 8.0
            layout.headerHeight = 50.0
            collectionView.collectionViewLayout = layout
            collectionView.register(UINib(nibName: "TextCell", bundle: nil), forCellWithReuseIdentifier: "TextCell")
            collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
            collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
            collectionView.dataSource = self
        }
    }

    private lazy var response: SampleResponse = {
        let jsonURL = Bundle.main.url(forResource: "test_data", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        return try! JSONDecoder().decode(SampleResponse.self, from: jsonData)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Example"
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return response.contents.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch response.contents[section] {
        case .topicItem:
            return 1
        case .items:
            return response.items.count
        case .news:
            return response.news.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch response.contents[indexPath.section] {
        case .topicItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
            cell.configure(with: response.topicItem.color)
            return cell
        case .items:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
            cell.configure(with: response.items[indexPath.item].color)
            return cell
        case .news:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.backgroundColor = .lightGray
            let news = response.news[indexPath.item]
            cell.configure(with: (news.title, news.description))
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch response.contents[indexPath.section] {
            case .topicItem: header.configure(with: "Topic color using flow layout")
            case .items: header.configure(with: "Colors using waterfall layout")
            case .news: header.configure(with: "texts using auto layout")
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension ViewController: WaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch response.contents[indexPath.section] {
        case .topicItem:
            return response.topicItem.size
        case .items:
            return response.items[indexPath.item].size
        case .news:
            return WaterfallLayout.automaticSize //CGSize(width: 300, height: 180)
        }
    }

    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        switch response.contents[section] {
        case .topicItem: return .flow(column: 1)
        case .items: return .waterfall(column: 2)
        case .news: return .flow(column: 1)
        }
    }

}

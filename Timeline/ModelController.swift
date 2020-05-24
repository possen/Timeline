//
//  ModelController.swift
//  Timeline
//
//  Created by Paul Ossenbruggen on 5/23/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation
import UIKit.UIImage

class ModelController:NSObject {
    var timeline = Timeline<UIImage>()
    let timelineCellIdentifier = "TimelineCell"
    var elements = [(date: String, image: UIImage?)]()
    
    private func update<C: Collection>(_ collection: C) where C.Iterator.Element == UIImage? {
        let elements = zip(
            collection.indices, collection).map { (x: (C.Index, UIImage?)
        ) -> (date: String, image: UIImage?) in
            let (date, image) = x
            return (date: String(reflecting: date), image: image)
        }
        self.elements = elements
    }
    
    private func loadElements() -> [(date: Date, image: UIImage)] {
        let plistElements = NSArray(contentsOf: Bundle.main.url(
            forResource: "Timeline",
            withExtension: "plist")!
        )! as! [[String: AnyObject]]
        return plistElements.map { elem in
            return (date: elem["date"] as! Date, image: UIImage(named: elem["image"] as! String)!)
        }
    }
    
    func load() {
        for elem in loadElements() {
            timeline[elem.date] = elem.image
        }
        update(timeline)
    }
}

extension ModelController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return elements.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: timelineCellIdentifier,
            for: indexPath
            ) as! TimelineCell
        let data = elements[indexPath.row]
        cell.viewData = TimelineCell.ViewData(image: data.image, date: data.date, index: indexPath.row)
        return cell
    }
}

extension ModelController: UICollectionViewDelegate {
}


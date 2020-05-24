//
//  TimelineCell.swift
//  Timeline
//
//  Created by Paul Ossenbruggen on 5/23/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import UIKit

class TimelineCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    internal struct ViewData {
        let index: Int
        let image: UIImage?
        let date: String
    }
    var viewData: ViewData? {
        didSet {
            dateLabel.text = viewData?.date
            imageView.image = viewData?.image
        }
    }
}

extension TimelineCell.ViewData {
    
    internal init(image: UIImage?, date: String, index: Int) {
        self.image = image
        self.date = date
        self.index = index
    }
}

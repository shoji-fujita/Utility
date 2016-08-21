//
//  CollectionViewCell.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/21.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    func configureWithIndexPath(indexPath: NSIndexPath) {
        textLabel.preferredMaxLayoutWidth = width()
    }
}

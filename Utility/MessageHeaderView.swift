//
//  MessageHeaderView.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/07.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

class MessageHeaderView: UIView {

    @IBOutlet weak var dateLabel: PaddingLabel!
    
    class func view() -> MessageHeaderView {
        return UINib(nibName: "MessageHeaderView", bundle: nil).instantiateWithOwner(self, options: nil).first as! MessageHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.layer.cornerRadius = dateLabel.height()/2
        dateLabel.clipsToBounds = true
    }
}

class PaddingLabel: UILabel {
    let padding = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    
    override func drawTextInRect(rect: CGRect) {
        let newRect = UIEdgeInsetsInsetRect(rect, padding)
        super.drawTextInRect(newRect)
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        intrinsicContentSize.height += padding.top + padding.bottom
        intrinsicContentSize.width += padding.left + padding.right
        return intrinsicContentSize
    }
}

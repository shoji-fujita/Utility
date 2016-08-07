//
//  MessageSideView.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/07.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

class MessageSideView: UIView {
    @IBOutlet weak var isReadLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    class func view() -> MessageSideView {
        return UINib(nibName: "MessageSideView", bundle: nil).instantiateWithOwner(self, options: nil).first as! MessageSideView
    }
}

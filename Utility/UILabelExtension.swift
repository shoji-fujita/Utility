//
//  UILabelExtension.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/21.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

extension UILabel {
    
    func countLines() -> Int {
        let oneLineRect  =  "a".boundingRectWithSize(self.bounds.size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil)
        let boundingRect = text!.boundingRectWithSize(self.bounds.size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil)
        
        return Int(boundingRect.height / oneLineRect.height)
    }
}

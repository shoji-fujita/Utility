//
//  UIViewExtension.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/07.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

extension UIView {
    
    func x() -> CGFloat {
        return frame.origin.x
    }
    
    func y() -> CGFloat {
        return frame.origin.y
    }
    
    func height() -> CGFloat {
        return frame.size.height
    }
    
    func width() -> CGFloat {
        return frame.size.width
    }
    
    func left() -> CGFloat {
        return x()
    }
    
    func right() -> CGFloat {
        return x() + width()
    }
    
    func top() -> CGFloat {
        return y()
    }
    
    func bottom() -> CGFloat {
        return y() + height()
    }
}

//
//  ViewController.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/06.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        let vc = MessagesViewController()
//        let vc = TableCollectionViewController.view()
        let vc = TableViewController.view()
        self.presentViewController(vc, animated: true, completion: nil)
    }
}

func showMessagesViewController() {
    
}

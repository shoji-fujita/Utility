//
//  TableCollectionViewController.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/20.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

class TableCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var isFirst = true
    
    let names: [String] = ["redaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","blue","green","yellow"]
    let colors: [UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    
    class func view() -> TableCollectionViewController {
        return UIStoryboard(name: "TableCollectionViewController", bundle: nil).instantiateInitialViewController() as!TableCollectionViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        registerNib()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirst {
            isFirst = false
            let bannerView = UIView(frame: CGRect(x: 0, y: -collectionView.contentInset.top, width: collectionView.width() , height: 100))
            bannerView.backgroundColor = UIColor.blueColor()
            collectionView.addSubview(bannerView)
        }
    }
}

//MARK: - collectionViewDataSource
extension TableCollectionViewController {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = colors[indexPath.row]
        cell.textLabel.text = names[indexPath.row]
        
        return cell
    }
}

//MARK: - collectionViewDelegateFlowLayout
extension TableCollectionViewController {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.width()
        return CGSize(width: width, height: 44)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    // セクション間
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

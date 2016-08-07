//
//  MessagesViewController.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/06.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import SnapKit

class MessageItem: NSObject {
    var isRead: Bool = false
    var jsqMessage:JSQMessage!
    
    init(jsqMessage: JSQMessage, isRead: Bool) {
        super.init()
        self.jsqMessage = jsqMessage
        self.isRead = isRead
    }
}

//class MessageItems: NSObject {
//    
//    func addMessage(message: JSQMessage) -> [[JSQMessage]] {
//        
//    }
//    
//    override init() {
//        let messageItem = MessageItem(JSQMessage(senderId: "", senderDisplayName: "", date: NSDate(), text: "あいうえお"), isRead: false)
//        messageItem.jsp
//    }
//}

class MessagesViewController: JSQMessagesViewController {
    var messages: [[MessageItem]] =  [[]]
    var yourBubble: JSQMessagesBubbleImage?
    var myBubble: JSQMessagesBubbleImage?
    var yourAvatar: JSQMessagesAvatarImage?
    var myAvatar: JSQMessagesAvatarImage?
    
    // MEMO: test用
    var sectionHeaderStrings = ["2016/01/01(金)", "2016/01/02(金)", "今日"]
    let dates = [["11:00", "11:03"], ["12:30", "12:32"], ["12:30", "12:32"]]
    
    let myID = "myID"
    let yourID = "yourID"
    let myDisplayName = "myName"
    let yourDisplayName = "yourName"
    
    class func view() -> MessagesViewController {
        return UIStoryboard(name: "JSQMessagesViewController", bundle: nil).instantiateInitialViewController() as!MessagesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = myID
        self.senderDisplayName = ""
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.myBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        self.yourBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        
        self.myAvatar = nil
        self.collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        self.yourAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "icon_jibanyan"), diameter: 64)
        
        
        self.inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "icon_jibanyan"), forState: .Normal)
        self.inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "icon_jibanyan"), forState: .Highlighted)
        self.inputToolbar.contentView.textView.placeHolder = "何か入力して"
        self.inputToolbar.contentView.rightBarButtonItem.setTitle("送信", forState: .Normal)
        
        self.showLoadEarlierMessagesHeader = true
        
        let jsqMessage1 = JSQMessage(senderId: myID, senderDisplayName: senderDisplayName, date: NSDate(), text: "あいうえお")
        let jsqMessage2 = JSQMessage(senderId: yourID, senderDisplayName: senderDisplayName, date: NSDate(), text: "あいうえお")
        let jsqMessage3 = JSQMessage(senderId: myID, senderDisplayName: senderDisplayName, date: NSDate(), text: "あいうえお")
        let jsqMessage4 = JSQMessage(senderId: yourID, senderDisplayName: senderDisplayName, date: NSDate(), text: "あいうえお")
        messages = [
            [MessageItem(jsqMessage: jsqMessage1, isRead: false),
             MessageItem(jsqMessage: jsqMessage2, isRead: true),
             ],[
             MessageItem(jsqMessage: jsqMessage3, isRead: false),
             MessageItem(jsqMessage: jsqMessage4, isRead: true)]]
    }

    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
//        messages.append(message)
        self.finishSendingMessageAnimated(true)
        self.receiveAutoMessage()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.section][indexPath.item].jsqMessage
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.section][indexPath.item].jsqMessage
        if message.senderId == senderId {
            return myBubble
        } else {
            return yourBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.section][indexPath.item].jsqMessage
        if message.senderId == self.senderId {
            return myAvatar
        }
        return yourAvatar
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages[section].count
    }
    
    func receiveAutoMessage() {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.didFinishMessageTimer(_:)), userInfo: nil, repeats: false)
    }
    
    func didFinishMessageTimer(sender: NSTimer) {
        let message = JSQMessage(senderId: yourID, displayName: yourDisplayName, text: "Hello!")
//        messages.append(message)
        self.finishReceivingMessageAnimated(true)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath) as UICollectionReusableView
        switch kind {
        case UICollectionElementKindSectionHeader:
            let view = MessageHeaderView.view()
            view.frame = header.bounds
            view.dateLabel.text = sectionHeaderStrings[indexPath.section]
            header.addSubview(view)
            return header
        default:
            return header
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let avatarImageTap = UITapGestureRecognizer(target: self, action: #selector(self.tappedAvatar))
        cell.avatarImageView?.userInteractionEnabled = true
        cell.avatarImageView?.addGestureRecognizer(avatarImageTap)

        for subview in cell.contentView.subviews {
            if let sideView = subview as? MessageSideView {
                sideView.removeFromSuperview()
            }
        }
        let sideView = MessageSideView.view()
        cell.contentView.addSubview(sideView)
        
        sideView.isReadLabel.hidden = !messages[indexPath.section][indexPath.row].isRead
        sideView.dateLabel.text = dates[indexPath.section][indexPath.row] //messages[indexPath.section][indexPath.row].date
        
        if cell.isKindOfClass(JSQMessagesCollectionViewCellOutgoing) {
            cell.textView?.textColor = UIColor.whiteColor()
            sideView.snp_makeConstraints { make in
                make.height.equalTo(cell.messageBubbleContainerView)
                make.bottom.equalTo(cell.messageBubbleContainerView.snp_bottom)
                make.trailing.equalTo(cell.messageBubbleContainerView.snp_leading).offset(-5)
            }
            sideView.isReadLabel.textAlignment = .Right
            sideView.dateLabel.textAlignment = .Right
        } else {
            cell.textView?.textColor = UIColor.darkGrayColor()
            sideView.snp_makeConstraints { make in
                make.height.equalTo(cell.messageBubbleContainerView)
                make.bottom.equalTo(cell.messageBubbleContainerView.snp_bottom)
                make.leading.equalTo(cell.messageBubbleContainerView.snp_trailing).offset(5)
            }
            sideView.isReadLabel.textAlignment = .Left
            sideView.dateLabel.textAlignment = .Left
        }
        return cell
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        selectImage()
    }
    
    private func selectImage() {
        let alertController = UIAlertController(title: "画像を選択", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "カメラを起動", style: .Default) { (UIAlertAction) -> Void in
            self.selectFromCamera()
        }
        let libraryAction = UIAlertAction(title: "カメラロールから選択", style: .Default) { (UIAlertAction) -> Void in
            self.selectFromLibrary()
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) { (UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
    }
    
    func tappedAvatar() {
        print("tapped user avatar")
        let vc = ProfileViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
}

extension MessagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func selectFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラ許可をしていない時の処理")
        }
    }
    
    private func selectFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラロール許可をしていない時の処理")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] {
            sendImageMessage(image as! UIImage)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func sendImageMessage(image: UIImage) {
        let photoItem = JSQPhotoMediaItem(image: image)
        let imageMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, media: photoItem)
//        messages.append(imageMessage)
        finishSendingMessageAnimated(true)
    }
    
}









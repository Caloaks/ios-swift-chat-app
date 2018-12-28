//
//  OneOnOneChatViewController.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 02/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class OneOnOneChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var ChatViewBottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var ChatViewWithComponents: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatInputView: UITextView!
    @IBOutlet weak var chatTableview: UITableView!
    //Outlets Declarations
    @IBOutlet weak var videoCallBtn: UIBarButtonItem!
    @IBOutlet weak var audioCallButton: UIBarButtonItem!
    
    // Variable Declarations
    var buddyNameString:String!
    var buddyStatusString:String!
    //var buddyAvtar:String!
    var buddyAvtar:UIImage!
    var buddyName:UILabel!
    var buddyStatus:UILabel!
    let modelName = UIDevice.modelName
    
    let chatMessage = [ Message(messageText: "Hello Pushpsen", userID: "12", avatarURL: "default", messageType: "10", isSelf: false, isGroup: true),
                        Message(messageText: "Hi this is my first text message", userID: "12", avatarURL: "default", messageType: "10", isSelf: true, isGroup: true),
                        Message(messageText: "I want to have a string that is actually very long in length so that I can get a very large string at the o/p", userID: "12", avatarURL: "default", messageType: "10", isSelf: true, isGroup: true),
                        Message(messageText: "I want to have a string that is actually very long in length so that I can get a very large string at the o/p I want to have a string that is actually very long in length so that I can get a very large string at the o/p", userID: "12", avatarURL: "default", messageType: "10", isSelf: false, isGroup: true),  Message(messageText: "Hi Jeet", userID: "12", avatarURL: "default", messageType: "10", isSelf: false, isGroup: true)
                        ]
    
    
    
    
    fileprivate let cellID = "chatCell"
//    let chatMessages = ["Hi this is my first text message", "I want to have a string that is actually very long in length so that I can get a very large string at the o/p", "I want to have a string that is actually very long in length so that I can get a very large string at the o/p I want to have a string that is actually very long in length so that I can get a very large string at the o/p","Hi Jeet"]
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        //Registering Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Function Calling
        self.handleOneOnOneChatVCApperance()
        self.hideKeyboardWhenTappedAround()
        
        self.chatView.layer.borderWidth = 1
        self.chatView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.chatView.layer.cornerRadius = 20.0
        self.chatView.clipsToBounds = true
        self.chatInputView.delegate = self
        chatInputView.text = "Type a message..."
        chatInputView.textColor = UIColor.lightGray
        
        chatTableview.delegate = self
        chatTableview.dataSource = self
        
        //registerCell
        chatTableview.register(ChatTableViewCell.self, forCellReuseIdentifier: cellID)
        chatTableview.separatorStyle = .none
        chatTableview.allowsSelection = false
        //chatView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    func handleOneOnOneChatVCApperance(){
        
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        // ViewController Appearance
        
        self.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isTranslucent = false
        guard (UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView) != nil else {
            return
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        } else {
            
        }
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        //Video Button:
        videoCallBtn.image =  UIImage.init(named: "video_call.png")
        videoCallBtn.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        //Audio Button:
        audioCallButton.image =  UIImage.init(named: "audio_call.png")
        audioCallButton.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        //Send button:
        switch AppAppearance{
        case .facebook:
            sendBtn.backgroundColor = UIColor.init(hexFromString: "0084FF")
        case .whatsapp:
            sendBtn.backgroundColor = UIColor.init(hexFromString: "0084FF")
        case .cometchat:
            sendBtn.backgroundColor = UIColor.init(hexFromString: "2636BE")
        }
        
        
        //BuddyAvtar Apperance
    
        let containView = UIView(frame: CGRect(x: -10 , y: 0, width: 38, height: 38))
        containView.backgroundColor = UIColor.white
        containView.layer.cornerRadius = 19
        containView.layer.masksToBounds = true
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageview.image = buddyAvtar
        imageview.contentMode = UIView.ContentMode.scaleAspectFill
        imageview.layer.cornerRadius = 19
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        let leftBarButton = UIBarButtonItem(customView: containView)
        self.navigationItem.leftBarButtonItems?.append(leftBarButton)
        
        //TitleView Apperance
        let  titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        
        self.navigationItem.titleView = titleView
        buddyName = UILabel(frame: CGRect(x:0,y: 3,width: 150 ,height: 21))
        buddyName.textColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        buddyName.textAlignment = NSTextAlignment.left

        buddyName.text = buddyNameString
        buddyName.font = UIFont(name: SystemFont.regular.value, size: 18)
        titleView.addSubview(buddyName)
        
        buddyStatus = UILabel(frame: CGRect(x:0,y: titleView.frame.origin.y + 22,width: 200,height: 21))
        
        switch AppAppearance {
        case .facebook:
            buddyStatus.textColor = UIColor.init(hexFromString: "3E3E3E")
        case .whatsapp:
            buddyStatus.textColor = UIColor.init(hexFromString: "3E3E3E")
        case .cometchat:
             buddyStatus.textColor = UIColor.init(hexFromString: "FFFFFF")
        }

        buddyStatus.textAlignment = NSTextAlignment.left
        buddyStatus.text = buddyStatusString
        buddyStatus.font = UIFont(name: SystemFont.regular.value, size: 12)
        titleView.addSubview(buddyStatus)
        titleView.center = CGPoint(x: 0, y: 0)
        
        
        // More Actions:
        let tapOnProfileAvtar = UITapGestureRecognizer(target: self, action: #selector(UserAvtarClicked(tapGestureRecognizer:)))
        imageview.isUserInteractionEnabled = true
        imageview.addGestureRecognizer(tapOnProfileAvtar)
        
        
        let tapOnTitleView = UITapGestureRecognizer(target: self, action: #selector(TitleViewClicked(tapGestureRecognizer:)))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(tapOnTitleView)
        
    }

    
 
    
    @objc func UserAvtarClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
        navigationController?.pushViewController(profileAvtarViewController, animated: true)
        profileAvtarViewController.title = buddyNameString
        profileAvtarViewController.profileAvtar = buddyAvtar
        profileAvtarViewController.hidesBottomBarWhenPushed = true
    }
    
    
    @objc func TitleViewClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let UserProfileViewController = storyboard.instantiateViewController(withIdentifier: "userProfileViewController") as! UserProfileViewController
        navigationController?.pushViewController(UserProfileViewController, animated: true)
        UserProfileViewController.title = "View Profile"
        UserProfileViewController.getUserProfileAvtar = buddyAvtar
        UserProfileViewController.getUserName = buddyName.text
        UserProfileViewController.getUserStatus = buddyStatus.text
        UserProfileViewController.hidesBottomBarWhenPushed = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userinfo = notification.userInfo
        {
            let keyboardFrame = (userinfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            
            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
                 self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else if(modelName == "iPhone XS Max"){
               self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
                print("I m in iphone x")
                self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if(modelName == "iPhone XR"){
                self.view.frame.origin.y = -keyboardFrame!.height + 32;
            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }else{
                self.view.frame.origin.y = -keyboardFrame!.height + 60;
            }
           
        }
        
       
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("In keyboardWillHide")
        if self.view.frame.origin.y != 0 {
            if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
               self.view.frame.origin.y = 60
            }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
                self.view.frame.origin.y = 60
            }else if(modelName == "iPhone XS Max"){
                self.view.frame.origin.y = 32
            }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
                print("I m in iphone x")
                self.view.frame.origin.y = 32
            }else if(modelName == "iPhone XR"){
                self.view.frame.origin.y = 32
            }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
                self.view.frame.origin.y = 60
            }else{
                self.view.frame.origin.y = 60
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if chatInputView.text != ""{
            chatInputView.text = ""
            chatInputView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if chatInputView.text == ""{
            chatInputView.text = "Type a message..."
            chatInputView.textColor = UIColor.lightGray
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatTableViewCell
        
        cell.selectionStyle = .none
        
        let messageData = chatMessage[indexPath.row]
        cell.chatMessage = messageData
        //cell.isIncomingMessage = messageData.isSelf
        return cell
        
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        print(chatInputView.text!)
        
    }
    
    @IBAction func attachementButtonPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            
        }
        cameraAction.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo & Video Library", style: .default) { action -> Void in
            
        }
        photoLibraryAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        
        let documentAction: UIAlertAction = UIAlertAction(title: "Document", style: .default) { action -> Void in
            
        }
        documentAction.setValue(UIImage(named: "document.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoLibraryAction)
        actionSheetController.addAction(documentAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
        
    }

}


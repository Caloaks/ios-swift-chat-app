//
//  OneOnOneListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPulseSDK
class OneOnOneListViewController: UIViewController,UITableViewDelegate , UITableViewDataSource , CometChatDelegate {
    
    //Outlets Declarations
    @IBOutlet weak var oneOneOneTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!

    //Variable Declarations
    private var _blurView: UIVisualEffectView?
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var getUserArray:Array<User>!
    var userRequest:UsersRequest!
    private let limit = 10
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        //Function Calling
        self.fetchUsers()
        
        //Assigning Delegates
        oneOneOneTableView.delegate = self
        oneOneOneTableView.dataSource = self
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Function Calling
        self.handleContactListVCAppearance()
    }
    
    
    func fetchUsers(){
    
    // This Method fetch the users from the Server.
        
        getUserArray = Array<User>()
        
        
        fetchData_().fetchUsers { (users, error) in

            guard let userReceived = users else
            {
                print(error!.errordescription)
                return
            }
            for user in users! {
                self.getUserArray.append(user)
                print("users in array: \(user)")
                print("users  array: \(String(describing: users))")
            }
            DispatchQueue.main.async(execute: { self.oneOneOneTableView.reloadData()
            })
        }

//        userRequest = UsersRequest.UsersRequestBuilder(limit: limit).build()
//
//        userRequest.fetchNext { (userArray, error) in
//            for newUser:User in userArray!{
//                self.getUserArray.append(newUser)
//
//            }
//            DispatchQueue.main.async(execute: { self.oneOneOneTableView.reloadData()
//            })
//        }
    }
    
    //This method handles the UI customization for ContactListVC
    func  handleContactListVCAppearance(){
        
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearance.BACKGROUND_COLOR)
        
        //TableView Appearance
        self.oneOneOneTableView.cornerRadius = CGFloat(UIAppearance.TABLEVIEW_CORNER_RADIUS)
        
        
        // NavigationBar Appearance
        navigationItem.title = "Contacts"
        let normalTitleforNavigationBar = [
            NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_TITLE_COLOR),
            NSAttributedString.Key.font: UIFont(name: UIAppearance.NAVIGATION_BAR_TITLE_FONT, size: CGFloat(UIAppearance.NAVIGATION_BAR_TITLE_FONT_SIZE))!]
        navigationController?.navigationBar.titleTextAttributes = normalTitleforNavigationBar
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_COLOR)
        
        if #available(iOS 11.0, *) {
                navigationController?.navigationBar.prefersLargeTitles = true
                let letlargeTitleforNavigationBar = [
                NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_LARGE_TITLE_COLOR),
                NSAttributedString.Key.font: UIFont(name: UIAppearance.NAVIGATION_BAR_LARGE_TITLE_FONT, size: CGFloat(UIAppearance.NAVIGATION_BAR_LARGE_TITLE_FONT_SIZE))!]
                navigationController?.navigationBar.largeTitleTextAttributes = letlargeTitleforNavigationBar
        } else {
            
        }
        
        // NavigationBar Buttons Appearance
        notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
        notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        createButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
    }
    
    
   //TableView Methods
    
    //numberOfRowsInSection:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return getUserArray.count
    }
    
    //cellForRowAt indexPath :
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let buddyData:User = self.getUserArray[indexPath.row]
    
        let cell = oneOneOneTableView.dequeueReusableCell(withIdentifier: "oneOnOneTableViewCell") as! OneOnOneTableViewCell
        
        //User Name:
        cell.buddyName.text = buddyData.name
         //User Status:
        cell.buddyStatus.text = buddyData.status
        
        //User status Icon:
        if(buddyData.status == "offline"){
            cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "808080")
        }else if(buddyData.status == "busy"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "E45163")
        }else if(buddyData.status == "away"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "EBC04F")
        }else if(buddyData.status == "available"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "4AB680")
        }
        
        // User Avtar :
        let buddyURL:String = buddyData.avatar ?? "hello"
        cell.buddyAvtar.imageFromURL(urlString:buddyURL)
        
        return cell
    }
    
    //willDisplaycell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == getUserArray.count - 5){
            
            
//            userRequest.fetchNext { (userArray, error) in
//                for newUser:User in userArray!{
//                    self.getUserArray.append(newUser)
//                }
//                DispatchQueue.main.async(execute: {
//                    self.oneOneOneTableView.reloadData()
//                })
//            }
        }
    }
    
    //didSelectRowAt indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "oneOnOneChatViewController", sender: self)
    }
    
     //heightForRowAt indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    //trailingSwipeActionsConfigurationForRowAt indexPath
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            completionHandler(true)
        })
        action.image = UIImage(named: "delete.png")
        action.backgroundColor = .red
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
        })
        
        deleteAction.image = UIImage(named: "block.png")
        deleteAction.backgroundColor = .orange
        
        let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
        return confrigation
    }
    
    
    //leadingSwipeActionsConfigurationForRowAt indexPath
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            completionHandler(true)
        })
        action.image = UIImage(named: "video_call.png")
        action.backgroundColor = .green
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "audio_call.png")
        deleteAction.backgroundColor = .blue
        
        let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
        return confrigation
    }
    
    
    //announcement button Pressed
    @IBAction func announcementPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "ccwebviewController") as! CCWebviewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "Announcements"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    //More button Pressed
    @IBAction func morePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "More"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    //createContact button Pressed
    @IBAction func createContactPressed(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "Create Contact", style: .default) { action -> Void in
        }
        firstAction.setValue(UIImage(named: "createContact.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }

    
    func didReceiveMessage(message: BaseMessage?, error: CCException?) {
        
    }

}

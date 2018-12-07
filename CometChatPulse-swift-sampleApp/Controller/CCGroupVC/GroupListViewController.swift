//
//  GroupListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPulseSDK

class GroupListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //Outlets Declarations
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    //Variable Declarations
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var joinedChatRoomList:Array<Group>!
    var othersChatRoomList:Array<Group>!
    var groupRequest:GroupsRequest!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchGroupList()
        
        //Assigning Delegates
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Calling Function
        self.handleGroupListVCAppearance()
    }
    
    func fetchGroupList(){

        //This method fetches the grouplist from the server
        
     joinedChatRoomList = Array<Group>()
     othersChatRoomList = Array<Group>()
        
        fetchData_().fetchGroupList { (groupList, error) in
            
            guard let groupListReceived = groupList else
            {
                print(error!.errordescription)
                return
            }
            for group in groupList! {
                if(group.isJoined == true){
                    self.joinedChatRoomList.append(group)
                    print("joinedChatRoomList is:",self.joinedChatRoomList)
                }else{
                    self.othersChatRoomList.append(group)
                    print("othersChatRoomList is:",self.othersChatRoomList)
                }
            }
            DispatchQueue.main.async(execute: { self.groupTableView.reloadData()
            })
        }
    
//     groupRequest = GroupsRequest.GroupsRequestBuilder(Limit: 10).build()
//
//        groupRequest.fetchNext { (groupArray, Error) in
//
//            for newGroup:Group in groupArray!{
//
//                if(newGroup.isJoined == true){
//                    self.joinedChatRoomList.append(newGroup)
//                    print("joinedChatRoomList is:",self.joinedChatRoomList)
//                }else{
//                    self.othersChatRoomList.append(newGroup)
//                    print("othersChatRoomList is:",self.othersChatRoomList)
//                }
//            }
//
//            DispatchQueue.main.async(execute: {
//                self.groupTableView.reloadData()
//            })
//
//        }
        
    }
    
    //This method handles the UI customization for handleGroupListVC
    func  handleGroupListVCAppearance(){
        
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearance.BACKGROUND_COLOR)
        
        //TableView Appearance
        self.groupTableView.cornerRadius = CGFloat(UIAppearance.TABLEVIEW_CORNER_RADIUS)
        
        //        groupTableView.backgroundView?.tintColor = UIColor.white
        //        groupTableView.backgroundColor = UIColor.white
        //        groupTableView.tintColor = UIColor.white
        
        // NavigationBar Appearance
        navigationItem.title = "Groups"
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
    
//TableView Methods:
    
    //numberOfSections -->
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //numberOfRowsInSection -->
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return joinedChatRoomList.count
        } else {
            return othersChatRoomList.count
        }
    }
    
    //cellForRowAt indexPath -->
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupTableViewCell") as! GroupTableViewCell
        var group:Group!
        
        if(indexPath.section == 0){
            group = joinedChatRoomList[indexPath.row]
        }else{
            group = othersChatRoomList[indexPath.row]
        }
        
        cell.groupName.text = group.name
        let groupIconURL:String = group.icon ?? "null"
        cell.groupAvtar.imageFromURL(urlString:groupIconURL)
        cell.groupParticipants.text = "Participants : 00"
        
        return cell
    }
    
    //titleForHeaderInSection indexPath -->
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section==0) {
            return "JOINED GROUPS"
        }
        else {
            return "OTHER GROUPS"
        }
    }
    
    //heightForRowAt indexPath -->
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //trailingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        action.image = UIImage(named: "delete.png")
        action.backgroundColor = .red
        
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "block.png")
        deleteAction.backgroundColor = .orange
        
        let confrigation = UISwipeActionsConfiguration(actions: [action])
        
        return confrigation
    }
    
    //leadingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        action.image = UIImage(named: "video_call.png")
        action.backgroundColor = .green
        
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "audio_call.png")
        deleteAction.backgroundColor = .blue
        
        let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
        
        return confrigation
    }
    
    //Announcement Button Pressed
    @IBAction func announcementPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "ccwebviewController") as! CCWebviewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "Announcements"
        CCWebviewController.hidesBottomBarWhenPushed = true
        
    }
    
    //MoreSettinngs  Button Pressed
    @IBAction func morePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "More"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    //CreateGroup Button Pressed
    @IBAction func createGroupPressed(_ sender: Any) {
        
    let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let createGroupAction: UIAlertAction = UIAlertAction(title: "Create Group", style: .default) { action -> Void in
               
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupcontroller = storyboard.instantiateViewController(withIdentifier: "createGroupcontroller") as! CreateGroupcontroller
        self.navigationController?.pushViewController(createGroupcontroller, animated: false)
        createGroupcontroller.title = "Create Group"
        createGroupcontroller.hidesBottomBarWhenPushed = true
        }
        createGroupAction.setValue(UIImage(named: "createGroup.png"), forKey: "image")
        
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(createGroupAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }

}

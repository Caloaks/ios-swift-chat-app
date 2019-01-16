//
//  GroupListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatSDK

class GroupListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate{

    //Outlets Declarations
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    //Variable Declarations
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var groupArray:Array<Group>!
    var joinedChatRoomList:Array<Group>!
    var othersChatRoomList:Array<Group>!
    var groupRequest:GroupsRequest!
    var searchController:UISearchController!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchGroupList()
        
        //Memory Allocation
        joinedChatRoomList = [Group]()
        othersChatRoomList = [Group]()
        
        //Triggering Notifications
        DispatchQueue.global().async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.fetchGroupListFrom(_:)), name: NSNotification.Name(rawValue: "com.groupsData"), object: nil)
        }
        groupTableView.reloadData()
        
        //Assigning Delegates
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.global().async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.fetchGroupListFrom(_:)), name: NSNotification.Name(rawValue: "com.groupsData"), object: nil)
        }
        //Calling Function
        self.handleGroupListVCAppearance()
    }
    
    @objc func fetchGroupListFrom(_ notification: NSNotification) {
        
        print("CallingfetchGroupListFrom \(notification)")
        groupArray = notification.userInfo?["groupsData"] as? Array<Group>
        //groupArray = ((notification.userInfo["groupsData"]) as! Array<Group>)
        DispatchQueue.main.async{
             self.groupTableView.reloadData()
        }
       
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

    }
    
    //This method handles the UI customization for handleGroupListVC
    func  handleGroupListVCAppearance(){
        
        // ViewController Appearance
         view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        self.groupTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance:self.groupTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
        
        // NavigationBar Appearance
        navigationItem.title = "Groups"
        let normalTitleforNavigationBar = [
            NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR),
            NSAttributedString.Key.font: UIFont(name: SystemFont.regular.value, size: 21)!]
        navigationController?.navigationBar.titleTextAttributes = normalTitleforNavigationBar
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let letlargeTitleforNavigationBar = [
                NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR),
                NSAttributedString.Key.font: UIFont(name: SystemFont.bold.value, size: 40)!]
            navigationController?.navigationBar.largeTitleTextAttributes = letlargeTitleforNavigationBar
        }
        
        // NavigationBar Buttons Appearance
        
       // notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
        //notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        createButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        // SearchBar Apperance
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
        }
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        let SearchImageView = UIImageView.init()
        let SearchImage = UIImage(named: "icons8-search-30")!.withRenderingMode(.alwaysTemplate)
        SearchImageView.image = SearchImage
        SearchImageView.tintColor = UIColor.init(white: 1, alpha: 0.5)
        
        searchController.searchBar.setImage(SearchImageView.image, for: UISearchBarIcon.search, state: .normal)
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            if let backgroundview = textfield.subviews.first{
                
                // Background color
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            
        }
        
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
        cell.groupAvtar.downloaded(from: groupIconURL)
        cell.groupParticipants.text = group.groupDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let oneOnOneChatViewController = storyboard.instantiateViewController(withIdentifier: "oneOnOneChatViewController") as! OneOnOneChatViewController
       // oneOnOneChatViewController.buddyStatusString = selectedCell.groupName.text
        oneOnOneChatViewController.buddyAvtar = selectedCell.groupAvtar.image
        oneOnOneChatViewController.buddyNameString = selectedCell.groupName.text
        
        // self.performSegue(withIdentifier: "showDetail", sender: self)
        navigationController?.pushViewController(oneOnOneChatViewController, animated: true)
        
        
    }
    
    //titleForHeaderInSection indexPath -->
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0) {
            return "Joined Groups"
        }
        else {
            return "Other Groups"
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
        
      
        
    }
    
    //MoreSettinngs  Button Pressed
    @IBAction func morePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: true)
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

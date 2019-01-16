//
//  OneOnOneListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatSDK
class OneOnOneListViewController: UIViewController,UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
    
    //Outlets Declarations
    @IBOutlet weak var oneOneOneTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    //Variable Declarations
    private var _blurView: UIVisualEffectView?
    var searchController:UISearchController!
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var getUserArray:[User]!
    var userRequest:UsersRequest!
    private let limit = 10
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Memory Allocation
        getUserArray = [User]()
        
        
         //Triggering Notifications
        DispatchQueue.global().async {
             NotificationCenter.default.addObserver(self, selector: #selector(self.fetchUsers(_:)), name: NSNotification.Name(rawValue: "com.usersData"), object: nil)
        }
        oneOneOneTableView.reloadData()
       
       
        
        //Function Calling
        
        //Assigning Delegates
        oneOneOneTableView.delegate = self
        oneOneOneTableView.dataSource = self
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Triggering Notifications
        DispatchQueue.global().async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.fetchUsers(_:)), name: NSNotification.Name(rawValue: "com.usersData"), object: nil)
        }
        //Function Calling
        self.handleContactListVCAppearance()
    }
    
    
    @objc func fetchUsers(_ notification: NSNotification) {
        
        print("CallingFetchUsers")
        getUserArray = (notification.userInfo!["usersData"] as! Array<User>)
        self.oneOneOneTableView.reloadData()
    }
    
    
    //This method handles the UI customization for ContactListVC
    func  handleContactListVCAppearance(){
        
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        self.oneOneOneTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        oneOneOneTableView.tableFooterView = UIView(frame: .zero)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance:self.oneOneOneTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
        
        // NavigationBar Appearance
        
        navigationItem.title = "Contacts"
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
        } else {
            
        }
        
        // NavigationBar Buttons Appearance
       // notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
       // notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
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
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true;
            }
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
           
        }
        
    }
    
    
   //TableView Methods
    
    //numberOfRowsInSection:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return getUserArray.count
       // return 0
    }
    
    //cellForRowAt indexPath :
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let buddyData:User = self.getUserArray[indexPath.row]
    
        let cell = oneOneOneTableView.dequeueReusableCell(withIdentifier: "oneOnOneTableViewCell") as! OneOnOneTableViewCell
        
        //User Name:
        cell.buddyName.text = buddyData.name
        
         //User Status:
        cell.buddyStatus.text = buddyData.status
        cell.UID = buddyData.uid
        
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
        cell.buddyAvtar.downloaded(from: buddyData.avatar ?? "")
        
        return cell
    }
    
    //willDisplaycell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == getUserArray.count/2){

            fetchData_().fetchUsers { (users, error) in

                guard users != nil else
                {
                    print(error!.errordescription)
                    return
                }
                for user in users! {
                    self.getUserArray.append(user)
                    print("getUserArray:\(user)")
                    print("getUserArray: \(String(describing: users))")
                }
                self.oneOneOneTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
        
        
    }
    

    
    

    //didSelectRowAt indexPath
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

   
        let selectedCell:OneOnOneTableViewCell = tableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let oneOnOneChatViewController = storyboard.instantiateViewController(withIdentifier: "oneOnOneChatViewController") as! OneOnOneChatViewController
        oneOnOneChatViewController.buddyUID = selectedCell.UID
        oneOnOneChatViewController.buddyStatusString = selectedCell.buddyStatus.text
        oneOnOneChatViewController.buddyAvtar = selectedCell.buddyAvtar.image
        oneOnOneChatViewController.buddyNameString = selectedCell.buddyName.text
    
  // self.performSegue(withIdentifier: "showDetail", sender: self)
        navigationController?.pushViewController(oneOnOneChatViewController, animated: true)
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        print("i m here");
//       if segue.identifier == "showDetail" {
//            if let indexPath =  oneOneOneTableView.indexPathForSelectedRow {
//                let selectedCell:OneOnOneTableViewCell = oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
//                let controller = (segue.destination as! UINavigationController).topViewController as! OneOnOneChatViewController
//                print("slected name:\(String(describing: selectedCell.buddyName.text))")
//                controller.buddyNameString = selectedCell.buddyName.text
//                controller.buddyAvtar = selectedCell.buddyAvtar.image
//                controller.buddyStatusString = selectedCell.buddyStatus.text
//                controller.navigationItem.leftBarButtonItem = navigationItem.backBarButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//                
//            }
//        }
//    }
    
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
      
    }
    
    //More button Pressed
    @IBAction func morePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: true)
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


}

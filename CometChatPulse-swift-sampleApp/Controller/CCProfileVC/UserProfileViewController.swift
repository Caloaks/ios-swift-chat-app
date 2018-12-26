//
//  UserProfileViewController.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by pushpsen airekar on 08/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit


class UserProfileCell {
    
    static let AUDIO_CALL_CELL = 0
    static let VIDEO_CALL_CELL = 1
    
}

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    //Outlets Declarations
    @IBOutlet weak var userProfileAvtar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userProfileTableView: UITableView!
    @IBOutlet weak var profileAvtarBackground: UIView!
    
    
    //Variable Declarations
    var getUserProfileAvtar:UIImage!
    var getUserName:String!
    var getUserStatus:String!
    var profileItems:[Int]!
    
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Assigning Delegates
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self

        profileItems = []
        
        profileItems.append(UserProfileCell.AUDIO_CALL_CELL)
        profileItems.append(UserProfileCell.VIDEO_CALL_CELL)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleCCProfileAvtarVCAppearance()
    }
    
    //This method handles the UI customization for WebVC
    func  handleCCProfileAvtarVCAppearance(){
        
        // ViewController Appearance
        
        self.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes  = [NSAttributedStringKey.foregroundColor: UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)]
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
        
        // User Profile BAckground
        profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        // UserProfile Name
        userName.text = getUserName
        
        //UserProfile Status
        userStatus.text = getUserStatus
        
        // Profile Avtar
        userProfileAvtar.image = getUserProfileAvtar
        userProfileAvtar.cornerRadius = 100
        userProfileAvtar.clipsToBounds = true
        
        //TableView APpearance
        self.userProfileTableView.separatorColor = UIColor.clear
        userProfileTableView.backgroundColor = UIColor.clear
        userProfileTableView.tintColor = UIColor.clear
    }
    
    
    // TableView Methods:
    
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userProfileTableView.dequeueReusableCell(withIdentifier: "userProfileViewCell") as! UserProfileViewCell
        
        switch profileItems[indexPath.row]{
        case UserProfileCell.AUDIO_CALL_CELL:
        
            cell.CellLeftImage.isHidden = true
            cell.CellTitle.text = "Audio Call"
            let image = UIImage(named: "audio_call")!.withRenderingMode(.alwaysTemplate)
            cell.CellRightImage.image = image
            cell.CellRightImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        case UserProfileCell.VIDEO_CALL_CELL:
            cell.CellLeftImage.isHidden = true
            cell.CellTitle.text = "Video Call"
            let image = UIImage(named: "video_call")!.withRenderingMode(.alwaysTemplate)
            cell.CellRightImage.image = image
            cell.CellRightImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        default:
            cell.CellTitle.text = ""
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    


}

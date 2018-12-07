//
//  CreateGroupcontroller.swift
//  CometChatUI
//
//  Created by Admin1 on 21/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class CreateGroupcontroller: UIViewController {

    //Outlets Declaration
    @IBOutlet weak var groupType: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Function Calling
        self.handleCreateGroupVCAppearance()
    }
    
     //This method handles the UI customization for CreateGroupVC
    func handleCreateGroupVCAppearance() {
        
        // ViewController Appearance

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
        backBTN.tintColor = UIColor.white
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        
        // UIButton Appearance
        createButton.backgroundColor = UIColor.init(hexFromString: "007AFF")
        createButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.setTitleColor(UIColor.init(hexFromString: "007AFF"), for: .normal)
        cancelButton.layer.borderColor = UIColor.init(hexFromString: "007AFF").cgColor
        
    }

    //Cancel Button Pressed
    @IBAction func cancelPressed(_ sender: Any) {
        
        
    }
    
    //CreateGroup Button Pressed
    @IBAction func createGroupPressed(_ sender: Any) {
        
        
    }
    
    //selectGroupType Button Pressed
    @IBAction func selectGroupType(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let publicGroup: UIAlertAction = UIAlertAction(title: "Public Group", style: .default) { action -> Void in
            
            self.groupType.text = "Public Group"
        
        }
        let passwordProtectedGroup: UIAlertAction = UIAlertAction(title: "Password - Protected", style: .default) { action -> Void in
            
             self.groupType.text = "Password - Protected "
            
        }
        let privateGroup: UIAlertAction = UIAlertAction(title: "Private Group", style: .default) { action -> Void in
            
             self.groupType.text = "Private Group"
            
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(publicGroup)
        actionSheetController.addAction(passwordProtectedGroup)
         actionSheetController.addAction(privateGroup)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
        
    }
}

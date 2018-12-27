//
//  LoginViewController.swift
//  CometChatUI
//
//  Created by Admin1 on 16/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPulseSDK

class LoginViewController: UIViewController, CometChatPulseDelegate ,UITextFieldDelegate {
    
    //Outlets Declaration
    @IBOutlet weak var bottomViewTop: NSLayoutConstraint!
    @IBOutlet weak var bottomViewUpArrow: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var UserNameView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var tryADemo: UIButton!
    
    //Variable Declarations
    var cometchat:CometChat!
    let modelName = UIDevice.modelName
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

       //Funtion Calling
        self.handleLoginVCApperance()
        self.hideKeyboardWhenTappedAround()
        
        //Assigning Delegates
        userName.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Funtion Calling
        self.handleTopViewDistance()
    }
    
    
    func handleLoginVCApperance(){
        
        //View Apperance
        self.view.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.UserNameView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.PasswordView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.loginButton.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.loginButton.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        self.tryADemo.setTitleColor(UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR), for: .normal)
        self.switchBtn.tintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        self.switchBtn.onTintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
    
    }
    
    @IBAction func login(_ sender: Any) {
        
        let API_KEY:String = Bundle.main.infoDictionary?["API_KEY"] as! String
        
        CometChat.login(withUid: userName.text!, apiKey: API_KEY, onSuccess: { (current_user) in
            print("login sucess:",current_user)
            //UIButton State Change
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            //Navigate to Next VC
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
     
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
            }
            
        }) { (error) in
            print("login error: \(String(describing: error))")
            DispatchQueue.main.async { [unowned self] in
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                self.loginButton.setTitle("Login Failure", for: .normal)
            }
        }
    }
    
    @IBAction func guestLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
        self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
    }

    
    func handleTopViewDistance(){
        
        if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            bottomViewTop.constant = 50
        }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            bottomViewTop.constant = 50
        }else if(modelName == "iPhone XS Max"){
            bottomViewTop.constant = 70
        }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            bottomViewTop.constant = 68
        }else if(modelName == "iPhone XR"){
            bottomViewTop.constant = 70
        }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            bottomViewTop.constant = 50
        }else{
            bottomViewTop.constant = 50
            
        }
    }

    
    func didReceiveMessage(message: BaseMessage?, error: CCException?) {
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
   
}

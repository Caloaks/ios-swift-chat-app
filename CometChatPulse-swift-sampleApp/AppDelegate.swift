//
//  AppDelegate.swift
//  CometChatUI
//
//  Created by Admin1 on 15/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import  CometChatSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , CometChatCallDelegate {
   
    

    var window: UIWindow?
    var cometchat:CometChat!
    
    func initialization(){
        // init the Cometchat by using your app id
        
        let App_ID:String = Bundle.main.infoDictionary?["APP_ID"] as! String
        
        cometchat = CometChat(appId:App_ID ) { (error) in
            print("error is : \(error)")
        }
        
        //Assigning Delegate
    }
    
    func setupGlobalAppearance(){
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     
        self.initialization()
        self.setupGlobalAppearance()
        UIFont.overrideInitialize()
        
      switch AppAppearance{
        case .cometchat:
            application.statusBarStyle = .lightContent
//            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//            // Sets shadow (line below the bar) to a blank image
//            UINavigationBar.appearance().shadowImage = UIImage()
//            // Sets the translucent background color
//            UINavigationBar.appearance().backgroundColor = .clear
//            // Set translucent. (Default value is already true, so this can be removed if desired.)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .clear
        case .facebook: break
            
        case .whatsapp: break
            
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        CometChat.startServices()
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // Calling Delegates
    
    func onIncomingCall(aIncomingCall: Call?, error: CCException?) {
       
        print("aIncomingCall : \(aIncomingCall)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
//        CallingViewController.userAvtarImage = buddyAvtar
        CallingViewController.callingString = "Incoming Call"
//        CallingViewController.userNameString = buddyName.text
        CallingViewController.isAudioCall = true
        self.window?.rootViewController?.present(CallingViewController, animated: true, completion: nil)
        
    }
    
    func onCallAccepted(aAcceptedCall: Call?, error: CCException?) {
        
    }
    
    func onCallRejected(aRejectedCall: Call?, error: CCException?) {
        
    }


}


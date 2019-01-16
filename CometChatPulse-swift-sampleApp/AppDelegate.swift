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
class AppDelegate: UIResponder, UIApplicationDelegate{
   
    
    var window: UIWindow?
    var cometchat:CometChat!
    
    func initialization(){
        // init the Cometchat by using your app id
        
        CometChat(appId: AuthenticationDict?["APP_ID"] as! String) { (error) in
            print("error is : \(error)")
        }
        //Assigning Delegate
      CometChat.calldelegate = self
        
        
    }
    
    func setupGlobalAppearance(){
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
        }
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
 
        self.initialization()
        self.setupGlobalAppearance()
        UIFont.overrideInitialize()
        
        switch AppAppearance{
            
        case .AzureRadiance:
            break
        case .MountainMeadow:
            break
        case .PersianBlue:
            
            application.statusBarStyle = .lightContent
            //            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            //            // Sets shadow (line below the bar) to a blank image
            //            UINavigationBar.appearance().shadowImage = UIImage()
            //            // Sets the translucent background color
            //            UINavigationBar.appearance().backgroundColor = .clear
            //            // Set translucent. (Default value is already true, so this can be removed if desired.)
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .clear
            
        case .Custom:
            break
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
    
}


extension AppDelegate : CometChatCallDelegate{
    
    // Calling Delegates
    
    func onIncomingCall(aIncomingCall: Call?, error: CCException?){
        
        DispatchQueue.main.async {
            
            // Check if user busy with any other call
            if (CometChat.currentCall == nil){
        //var buddyAvtar:UIImageView!
        // buddyAvtar.downloaded(from: aIncomingCall?.sender?.avatar ?? "")
        print("aIncomingCall: \(String(describing: aIncomingCall))")
        print("aIncomingCall: \(String(describing: aIncomingCall?.sender?.name))")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        
        //CallingViewController.userAvtarImage = buddyAvtar.image
        CallingViewController.callingString = "Incoming Call"
        CallingViewController.userNameString = aIncomingCall?.sender?.name
        CallingViewController.isIncoming = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = CallingViewController
                
                 }else{
                
                CometChat.rejectCall(call: aIncomingCall!, status: .busy, onSuccess: { (call_) in
                    
                    // Successfully rejected and sent busy tone to caller
                    
                }, onFailure: { (exception) in
                    
                    // failed to send busy tone to caller
                    
                });
                
            }
            
        }

    }
    
    func onCallAccepted(aAcceptedCall: Call?, error: CCException?) {
        
        CometChat.startCall(call: aAcceptedCall!, inView: inputView!, userJoined: { (user) in
            
        }, userLeft: { (user) in
            
        }, error: { (CCException) in
            
        }) { (call) in
            
        }
    }
    
    func onCallRejected(aRejectedCall: Call?, error: CCException?) {
        
        
    }
}
    



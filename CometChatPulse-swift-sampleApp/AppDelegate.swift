//
//  AppDelegate.swift
//  CometChatUI
//
//  Created by Admin1 on 15/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CometChatUserEventDelegate, CometChatCallDelegate, CometChatMessageDelegate, CometChatGroupEventDelegate,  UISplitViewControllerDelegate{
    func onUserOnline(user: User) {
        
    }
    
    func onUserOffline(user: User) {
        
    }
    
    func onIncomingCall(incomingCall: Call?, error: CometChatException?) {
        
    }
    
    func onCallAccepted(acceptedCall: Call?, error: CometChatException?) {
        
    }
    
    func onCallRejected(rejectedCall: Call?, error: CometChatException?) {
        
    }
    
    func onTextMessageReceived(textMessage: TextMessage?, error: CometChatException?) {
        
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage?, error: CometChatException?) {
        
    }
    
    func onUserJoined(joinedUser: User, joinedGroup: Group) {
        
    }
    
    func onUserLeft(leftUser: User, leftGroup: Group) {
        
    }
    
    func onUserKicked(kickedUser: User, kickedBy: User, kickedFrom: Group) {
        
    }
    
    func onUserBanned(bannedUser: User, bannedBy: User, bannedFrom: Group) {
        
    }
    
    func onUserUnbanned(unbannedUser: User, unbannedBy: User, unbannedFrom: Group) {
        
    }
    
    func onMemberScopeChanged(user: User, scopeChangedTo: String, scopeChangedFrom: String, group: Group) {
        
    }
    

    var window: UIWindow?
    var cometchat:CometChat!
    
    func initialization(){
        // init the Cometchat by using your app id
        
        let App_ID:String = Bundle.main.infoDictionary?["APP_ID"] as! String
        
//        cometchat = CometChat(appId:App_ID, onSuccess: <#(Bool) -> Void#> ) { (error) in
//            print("error is : \(error)")
//        }
        
        CometChat(appId: App_ID, onSuccess: { (Success) in
           print("Success ")
        }) { (error) in
            print("error is : \(error)")
        }
        
        //Assigning Delegate
        
        CometChat.calldelegate = self
        CometChat.messagedelegate = self
        CometChat.userEventdelegate = self
        CometChat.groupEventdelegate = self
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

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func didReceiveMessage(message: BaseMessage?, error: CometChatException?) {
        
    }
    


}


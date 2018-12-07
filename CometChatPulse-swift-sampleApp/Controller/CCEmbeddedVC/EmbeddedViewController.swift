//
//  EmbeddedViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPulseSDK

class EmbeddedViewController: UIViewController {

    //Outlets Declarations
    
    // Variable Declarations
    var joinGroupArray:Array<Group>!
    var otherGroupArray:Array<Group>!
    var groupRequest:GroupsRequest!
    var usersArray:Array<User>!
    var userRequest:UsersRequest!
    var usersArray1:Array<User>!
    private let limit = 10
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print("I m in Embedded");
    }
    
//    func fetchGroupList(){
//        
//        //This method fetches the grouplist from the server
//        
//        joinGroupArray = Array<Group>()
//        otherGroupArray = Array<Group>()
//        
//        fetchData_().fetchGroupList { (groupList, error) in
//            
//            guard groupList != nil else
//            {
//                print(error!.errordescription)
//                return
//            }
//            for group in groupList! {
//                if(group.isJoined == true){
//                    self.joinGroupArray.append(group)
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.groupList"), object: nil, userInfo: ["groupArray":[self.joinGroupArray]])
//                    print("joinedChatRoomList is:",self.joinGroupArray)
//                }else{
//                    self.otherGroupArray.append(group)
//                    print("othersChatRoomList is:",self.otherGroupArray)
//                }
//            }
//        }
//        
//        //     groupRequest = GroupsRequest.GroupsRequestBuilder(Limit: 10).build()
//        //
//        //        groupRequest.fetchNext { (groupArray, Error) in
//        //
//        //            for newGroup:Group in groupArray!{
//        //
//        //                if(newGroup.isJoined == true){
//        //                    self.joinedChatRoomList.append(newGroup)
//        //                    print("joinedChatRoomList is:",self.joinedChatRoomList)
//        //                }else{
//        //                    self.othersChatRoomList.append(newGroup)
//        //                    print("othersChatRoomList is:",self.othersChatRoomList)
//        //                }
//        //            }
//        //
//        //            DispatchQueue.main.async(execute: {
//        //                self.groupTableView.reloadData()
//        //            })
//        //
//        //        }
//        
//    }
//    
//    func fetchUsers(){
//        
//        // This Method fetch the users from the Server.
//        
//        usersArray = Array<User>()
//        
//        
//        fetchData_().fetchUsers { (users, error) in
//            
//            guard users != nil else
//            {
//                print(error!.errordescription)
//                return
//            }
//            for user in users! {
//                self.usersArray.append(user)
//                print("users in array: \(user)")
//                print("users  array: \(String(describing: users))")
//            }
//            
//        }
//        
//        //        userRequest = UsersRequest.UsersRequestBuilder(limit: limit).build()
//        //
//        //        userRequest.fetchNext { (userArray, error) in
//        //            for newUser:User in userArray!{
//        //                self.getUserArray.append(newUser)
//        //
//        //            }
//        //            DispatchQueue.main.async(execute: { self.oneOneOneTableView.reloadData()
//        //            })
//        //        }
//    }
//    

}



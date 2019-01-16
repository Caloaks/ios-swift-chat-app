//
//  EmbeddedViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class EmbeddedViewController: UIViewController {

    //Outlets Declarations
    
    // Variable Declarations
    var groupsArray:Array<Group>!
    var groupRequest:GroupsRequest!
    var usersArray:Array<User>!
    var userRequest:UsersRequest!
    var usersArray1:Array<User>!
    private let limit = 10
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I m in Embedded");
        
        //Function Calling
        self.fetchUsers()
        self.fetchGroupList()
    }
    
    func fetchGroupList(){
        
        //This method fetches the grouplist from the server
        
        groupsArray = Array<Group>()
        
        fetchData_().fetchGroupList { (groupList, error) in
            
            guard groupList != nil else
            {
                print(error!.ErrorDescription)
                return
            }
            for group in groupList! {
                    self.groupsArray.append(group)
                }
            
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.groupsData"), object: nil, userInfo: ["groupsData":[self.groupsArray]]);
            }
        }
        
    
    
    func fetchUsers(){
        // This Method fetch the users from the Server.
        
        print("Im in fetchUsers")
        usersArray = Array<User>()
        
        fetchData_().fetchUsers { (users, error) in
            
            guard users != nil else
            {
                print(error!.ErrorDescription)
                return
            }
            for user in users! {
                print("Im in users: \(String(describing: users))")
                self.usersArray.append(user)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.usersData"), object: nil, userInfo: ["usersData":self.usersArray])
        }
    }
    

}



//
//  FetchData.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 01/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation
import UIKit
import CometChatSDK


class fetchData_ {
    
    private var userRequest:UsersRequest!
    private var groupRequest:GroupsRequest!
    
    public typealias userResponse = (_ user:[User]? , _ error:CometChatException?) ->Void
    public typealias groupResponse = (_ group:[Group]? , _ error:CometChatException?) ->Void
    
    func fetchUsers(completionHandler:@escaping userResponse) {
        print("heere 11")
        userRequest = UsersRequest.UsersRequestBuilder(limit: 10).build()
        print("heere 22")
        userRequest.fetchNext { (users, error) in
            print("heere 33")
            guard let usersArray = users else {
                print("heere 44")
                completionHandler(nil,error)
                return
            }
            print("heere 55")
            completionHandler(usersArray,nil)
            
        }
    }
    
    func fetchGroupList(completionHandler:@escaping groupResponse) {
    
         groupRequest = GroupsRequest.GroupsRequestBuilder(Limit: 10).build()
        
         groupRequest.fetchNext { (groupList, error) in
            
            guard let groupListArray = groupList else {
                completionHandler(nil,error)
                return
            }
           completionHandler(groupListArray,nil)
        }
    }

}

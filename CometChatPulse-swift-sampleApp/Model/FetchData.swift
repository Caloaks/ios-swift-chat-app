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
    
    public typealias userResponse = (_ user:[User]? , _ error:CCException?) ->Void
    public typealias groupResponse = (_ group:[Group]? , _ error:CCException?) ->Void
    
    func fetchUsers(completionHandler:@escaping userResponse) {
        
        userRequest = UsersRequest.UsersRequestBuilder(limit: 60).build()
        
        userRequest.fetchNext { (users, error) in
            
            guard let usersArray = users else {
                completionHandler(nil,error)
                return
            }
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

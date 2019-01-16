//
//  FetchData.swift
//  CCPulse-CometChatUI-ios-master
//
//  Created by pushpsen airekar on 01/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation
import UIKit
import CometChatPro


class fetchData_ {
    
    private var userRequest:UsersRequest!
    private var groupRequest:GroupsRequest!
    
    public typealias userResponse = (_ user:[User]? , _ error:CometChatException?) ->Void
    public typealias groupResponse = (_ group:[Group]? , _ error:CometChatException?) ->Void
    
    func fetchUsers(completionHandler:@escaping userResponse) {
        print("heere 11")
        let userrequest = UsersRequest.UsersRequestBuilder(limit: 10).build()
        print("heere 22")
        userrequest.fetchNext(onSuccess: { (users) in
            
            let usersArray = users
            completionHandler(usersArray,nil)
            
            
        }) { (error) in
            
            completionHandler(nil,error)
            
        }
        
    }
    
    func fetchGroupList(completionHandler:@escaping groupResponse) {
        
        groupRequest = GroupsRequest.GroupsRequestBuilder(Limit: 10).build()
        groupRequest.fetchNext(onSuccess: { (groupList) in
            
            let groupListArray = groupList
            completionHandler(groupListArray,nil)
            
        }) { (error) in
            completionHandler(nil,error)
        }
        
    }

}

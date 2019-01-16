//
//  Call.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 04/01/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import Foundation
import  CometChatSDK

public enum callType{
    case audio
    case video
}


public enum callTo{
    case user
    case group
}


class Calling {
    
    func sendCall(aNewCall:Call){
        
        CometChat.sendCallRequest(call: aNewCall, onSuccess:  { (ongoing_call) in

            print("sendCallRequest onSuccess: \(String(describing: ongoing_call))")
            
        }) { (error) in
            print("sendCallRequest error: \(String(describing: error))")
        }
    }
}

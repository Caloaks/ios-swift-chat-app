//
//  ChatVCCallback.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 31/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation

import CometChatPulseSDK
let uid = "SUPERHERO2"
let text = "Hello"

let data = [Message].self

func initCallback()->Void{
    
    let textMessage = TextMessage(receiverUid: uid, text: text, messageType: .text, receiverType: .user)
    
    CometChat.sendTextMessage(message: textMessage, onSuccess: { (message) in
        
        // success
        // e.g
        // let sentMessage = (message as? TextMessage);
        // sentMessage?.text
        
    }) { (error) in
        
        // error
        // e.g error!.errordescription
    }
    
}

// *** STEP 4:.confirming to a protocol




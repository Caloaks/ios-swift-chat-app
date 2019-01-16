//
//  MessageResponse.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 09/01/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import Foundation
import CometChatSDK

struct getMessageResponse {
    
    let messages : [Message]
    
    init?(myMessageData : [BaseMessage]) throws {
        
        var messages = [Message]()
        var messageDict = [String : Any]()
        
        for myData in myMessageData{
            
            if(myData .isKind(of: TextMessage.self)){
                
                
                let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH:mm:a"
                
                dateFormatter1.timeZone = NSTimeZone.local
                let dateString : String = dateFormatter1.string(from: date)
                print("formatted date is =  \(dateString)")
                
                let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                let isSelf : Bool
                
                if(myUID == myData.senderUid){
                    
                    isSelf = true
                    
                }else {
                    
                    isSelf = false
                }
                
                if(myData.receiverType == CometChatConstants.receiverType.group){
                    
                    messageDict["isGroup"] = true
                    
                }else {
                    
                    messageDict["isGroup"] = false
                    
                }
                
                let myMessage = (myData as? TextMessage)
                print("myMessage is \(String(describing: myMessage?.text))")
                messageDict["userID"] = "11"
                messageDict["messageText"] = myMessage?.text
                messageDict["messageType"] = "text" //
                messageDict["isSelf"] = isSelf
                messageDict["time"] = dateString
                messageDict["avatarURL"] = "testURL"
                print("myDict is \(messageDict)")
                guard let message = Message(dict: messageDict) else { continue }
                print("MyMessage is 22222 \(message)")
                messages.append(message)
            }
        }
        self.messages = messages
        
    }
    
}

struct getSendMessageResponse {
    
    let messages : Message
    
    init?(myMessageData : BaseMessage) throws {
        
        var messageDict = [String : Any]()
            
            if(myMessageData .isKind(of: TextMessage.self)){
                
                print("here my timestam \(myMessageData.sentAt)")
                print("here the senderUID \(myMessageData.senderUid)")
                print("here the receiverUID \(myMessageData.receiverUid)")
                print("here the user is \(String(describing: myMessageData.sender))")
                
                let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH:mm a"
                
                dateFormatter1.timeZone = NSTimeZone.local
                let dateString : String = dateFormatter1.string(from: date)
                print("formatted date is =  \(dateString)")
            
                let myMessage = (myMessageData as? TextMessage)
                print("myMessage is \(String(describing: myMessage?.text))")
                
                if(myMessageData.receiverType == CometChatConstants.receiverType.group){
                    
                    messageDict["isGroup"] = true
                    
                }else {
                    
                    messageDict["isGroup"] = false
                    
                }
                
                messageDict["userID"] = "11"
                messageDict["messageText"] = myMessage?.text
                messageDict["messageType"] = "text" //
                messageDict["isSelf"] = true
                messageDict["time"] = dateString
                messageDict["avatarURL"] = "testURL"
                print("myDict is \(messageDict)")
                guard let message = Message(dict: messageDict) else { return nil  }
                print("MyMessage is new \(message)")
                self.messages = message
                
            }else{
                
                return nil
            }
       
        
        
    }
    
}


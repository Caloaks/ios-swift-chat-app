//
//  CallingViewController.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 02/01/19.
//  Copyright © 2019 Admin1. All rights reserved.


import UIKit
import CometChatSDK

class CallingViewController: UIViewController {
 
    

    //Outlets Declarations
    @IBOutlet weak var userAvtar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var callingBackgroundImage: UIImageView!
    @IBOutlet weak var callAcceptView: UIView!
    @IBOutlet weak var callSpeakerView: UIView!
    @IBOutlet weak var callRejectView: UIView!
    
    
    //Variable Declarations:
    var userNameString:String!
    var callingString:String!
    var userAvtarImage:UIImage!
    var callerUID:String!
    var isAudioCall:Bool!
    var receiverUid:String!
    var aNewCall:Call! = nil
    var callType:callType!
    var isIncoming:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Assigning Delegate
      
        //Function Calling
        
        if(isIncoming == false){
            callAcceptView.removeFromSuperview()
            callSpeakerView.removeFromSuperview()
             self.sendCallRequest()
        }
        self.handleCallingVCApperance()
        print("callerUID \(String(describing: callerUID))")
        print(isAudioCall)
        
        // Create CallObject:
    }

    
    func sendCallRequest(){
       
        if(isAudioCall){
            aNewCall = Call(receiverId:callerUID!, messageType: .audio, receiverType: .user)
        }else{
            aNewCall = Call(receiverId:callerUID!, messageType: .video, receiverType: .user)
        }
        
        CometChat.sendCallRequest(call: aNewCall, onSuccess:  { (ongoing_call) in
            
            print("sendCallRequest onSuccess: \(String(describing: ongoing_call))")
            print("sendCallRequest messageType: \(String(describing: ongoing_call?.messageType))")
            print("sendCallRequest callStatus: \(String(describing: ongoing_call?.callStatus))")
            print("sendCallRequest metaData: \(String(describing: ongoing_call?.metaData))")
            
        }) { (error) in
            print("sendCallRequest error: \(String(describing: error))")
        }
        
    }
    
    func handleCallingVCApperance(){
        
        userNameLabel.text = userNameString
        callingLabel.text = callingString
        userAvtar.image = userAvtarImage
        callingBackgroundImage.image = userAvtarImage
        callingBackgroundImage.addBlur()
        if(isAudioCall == false){
            callingBackgroundImage.removeFromSuperview()
        }
    }
    
    @IBAction func rejectPressed(_ sender: Any) {
        print("rejectPressed")
        
        self.dismiss(animated: true, completion: nil)
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
//        }
        
    }
    
    @IBAction func acceptPressed(_ sender: Any) {
        
        func onIncomingCall(incomingCall: Call?, error: CCException?) {
            
            DispatchQueue.main.async {
                
                // Check if user busy with any other call
                if (CometChat.currentCall == nil){

                    // if user is not busy on any other call
                    // motify user incoming call and Accept/reject the call
                    
                }else{
                    
                    // user is busy on another call
                    // user can end the ongoing call or reject the incoming call
                    // e.g.
                    CometChat.rejectCall(call: incomingCall!, status: .busy, onSuccess: { (call_) in
                        
                        // Successfully rejected and sent busy tone to caller
                        
                    }, onFailure: { (exception) in
                        
                        // failed to send busy tone to caller
                        
                    });
                    
                }
                
            }
        }
        
        
        
    }
    
    
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
   
    
    
}


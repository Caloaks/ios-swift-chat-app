//
//  CallingViewController.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 02/01/19.
//  Copyright © 2019 Admin1. All rights reserved.


import UIKit

class CallingViewController: UIViewController {

    
    //Outlets Declarations

    @IBOutlet weak var userAvtar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var callAccept: UIImageView!
     @IBOutlet weak var callReject: UIImageView!
    @IBOutlet weak var callingBackgroundImage: UIImageView!
    
    //Variable Declarations:
    var userNameString:String!
    var callingString:String!
    var userAvtarImage:UIImage!
    var isAudioCall:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Function Calling
        self.handleCallingVCApperance()
        
        print(isAudioCall)
       
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
       
        let tapOnAccept = UITapGestureRecognizer(target: self, action: #selector(AcceptPressed(tapGestureRecognizer:)))
        callAccept.isUserInteractionEnabled = true
        callAccept.addGestureRecognizer(tapOnAccept)
        
        
        let tapOnReject = UITapGestureRecognizer(target: self, action: #selector(RejectPressed(tapGestureRecognizer:)))
        callReject.isUserInteractionEnabled = true
        callReject.addGestureRecognizer(tapOnReject)
        
    }
    
    @objc func AcceptPressed(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
    }
    
    @objc func RejectPressed(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    

}

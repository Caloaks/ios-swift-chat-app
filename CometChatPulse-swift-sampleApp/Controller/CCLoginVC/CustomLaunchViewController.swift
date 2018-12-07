//
//  CustomLaunchViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 17/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class CustomLaunchViewController: UIViewController {

    //Outlets Declarations
    @IBOutlet weak var cometChatLogo: UIImageView!
    @IBOutlet weak var bottomV: UIView!
    
     //Variable Declarations
    var CCtabBarViewController = CCTabbar()
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Funtion Calling
        self.handleCustomLaunchVCApperance()
    }
    
    //This method handles the UI customization for CustomLaunchVC
    func handleCustomLaunchVCApperance(){
        
        UIView.animate(withDuration: 2, animations: {
            self.cometChatLogo.frame.origin.y  -= 200
        }, completion: { (finished: Bool) in
            self.CCtabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "CCtabBar") as! CCTabbar
            self.present(self.CCtabBarViewController, animated: false, completion: nil)
        })

    }
  
}

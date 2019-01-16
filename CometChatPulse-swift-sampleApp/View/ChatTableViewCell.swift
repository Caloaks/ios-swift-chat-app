//
//  ChatTableViewCell.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 27/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let messageBackgroundView = UIView()
    
    var leadingConstraint : NSLayoutConstraint!
    var trailingConstraint : NSLayoutConstraint!
    
    var enableOutGoingConstraintForbubble = Bool()
    
    
    var chatMessage : Message! {
        didSet{
//            messageBackgroundView.backgroundColor = chatMessage.isSelf ? UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR) : UIColor.lightGray
//            messageLabel.textColor = chatMessage.isSelf ? UIColor.white : UIColor.darkGray
            messageLabel.text = chatMessage.messageText
            
            if(chatMessage.isSelf){
                
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                        messageLabel.textColor = UIColor.white
                    
                case .MountainMeadow:
                    
                        self.messageBackgroundView.layer.cornerRadius = 15
                        messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                        messageLabel.textColor = UIColor.white
                    
                case .PersianBlue:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    
                       messageLabel.textColor = UIColor.white
                case .Custom:
                    
                        self.messageBackgroundView.layer.cornerRadius = 15
                        messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                        messageLabel.textColor = UIColor.white
                }
            
            }else {
                
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    
                     self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                        messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .MountainMeadow:
                    
                        self.messageBackgroundView.layer.cornerRadius = 15
                        messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                        messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .PersianBlue:
                
                self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .Custom:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //messageBackgroundView.backgroundColor = UIColor.blue
        messageBackgroundView.clipsToBounds = true
        messageBackgroundView.layer.cornerRadius = 15
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageBackgroundView)
        
        addSubview(messageLabel)
        
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 0
        //messageLabel.textColor = UIColor.white
        
        //Setting Constraints for MessageLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        //messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -12).isActive = true
        messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12).isActive = true
        messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant:12).isActive = true
        messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12).isActive = true
        
        //if(isIncomingMessage){
        leadingConstraint =  messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        leadingConstraint.isActive = false
        //}else {
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        trailingConstraint.isActive = true
        //}
        
//        switch AppAppearance{
//
//        case .facebook:
//            if(enableOutGoingConstraintForbubble){
//            self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0)
//            }else {
//                self.messageBackgroundView.layer.cornerRadius = 15
//            }
//
//            break
//
//        case .whatsapp:
//
//            self.messageBackgroundView.layer.cornerRadius = 15
//
//            break
//
//        case .cometchat:
//            if(enableOutGoingConstraintForbubble){
//            self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0)
//            }else {
//
//                self.messageBackgroundView.layer.cornerRadius = 15
//
//            }
//
//            break
//
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



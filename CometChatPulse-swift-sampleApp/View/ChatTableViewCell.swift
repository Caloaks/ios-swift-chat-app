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
    let messageTimeLabel = UILabel()
    let userAvatarImageView = UIImageView()
    
    var leadingConstraint : NSLayoutConstraint!
    var trailingConstraint : NSLayoutConstraint!
    var timeLabelLeadingConstraint : NSLayoutConstraint!
    var timeLabelTrailingConstraint : NSLayoutConstraint!
    
    var enableOutGoingConstraintForbubble = Bool()
    
    
    var chatMessage : Message! {
        didSet{

            messageLabel.text = chatMessage.messageText
            messageTimeLabel.text = chatMessage.time
            
            if(chatMessage.isSelf){
                
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                timeLabelTrailingConstraint.isActive = true
                timeLabelLeadingConstraint.isActive = false
                
                userAvatarImageView.isHidden = true
                
                switch AppAppearance{
                    
                case .facebook:
                self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white
                
                    break
                    
                case .whatsapp:
               
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white
            
                    break
                    
                case .cometchat:
                self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white

                    break
                    
                }
                
            }else {
                
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                timeLabelTrailingConstraint.isActive = false
                timeLabelLeadingConstraint.isActive = true
                
                userAvatarImageView.isHidden = false
                
                switch AppAppearance{
                    
                case .facebook:
                self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    break
                    
                case .whatsapp:
                    
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    break
                    
                case .cometchat:
                self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    break
                    
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
        addSubview(messageTimeLabel)
        
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 0
        
        //Setting Constraints for MessageLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -12).isActive = true
        messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12).isActive = true
        messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant:12).isActive = true
        messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12).isActive = true
        
        leadingConstraint =  messageLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 17)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        messageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabelLeadingConstraint = messageTimeLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: 5)
        timeLabelTrailingConstraint = messageTimeLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: -5)
        messageTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        messageTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        messageTimeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12).isActive = true
        messageTimeLabel.font = messageTimeLabel.font.withSize(10)
        messageTimeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
        
        
        addSubview(userAvatarImageView)
        
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        userAvatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        userAvatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.clipsToBounds = true
        userAvatarImageView.layer.cornerRadius = 12.5
        userAvatarImageView.image = UIImage(named: "default_user")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



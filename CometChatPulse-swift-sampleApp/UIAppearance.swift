//
//  UIAppearance.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 25/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation

public enum Appearance{
    case facebook
    case whatsapp
    case cometchat
}

extension String {
    
    var getApperance:Appearance? {
        
        switch self {
        case "FacebookUI":
            return Appearance.facebook
        case "WhatsappUI":
            return Appearance.whatsapp
        case "CometChatUI":
            return Appearance.cometchat
        default:
            return Appearance.cometchat;
        }
    }
    
}

var  AppAppearance:Appearance {
    
    if let UIApperance = Bundle.main.infoDictionary?["UIApperance"] as? String {
        
        return UIApperance.getApperance ?? .cometchat
    }
    return .cometchat;
}

enum fontTypes:String{
    case facebookRegular = "AvenirNext-Medium"
    case facebookBold = "AvenirNext-Bold"
    case facebookItalic = "AvenirNext-MediumItalic"
    case cometChatRegular = "ProductSans-Regular"
    case cometChatBold = "ProductSans-Bold"
    case cometChatItalic = "ProductSans-Italic"
    case whatsappRegular = "HelveticaNeue-Medium"
    case whatsappBold = "HelveticaNeue-Bold"
    case whatsappItalic = "HelveticaNeue-MediumItalic"
}

public enum SystemFont{
    case regular
    case bold
    case italic
    
    var value:String {
        
        switch self {
   
        case .regular:
            switch AppAppearance{
                case .facebook:
                return fontTypes.facebookRegular.rawValue
                case .whatsapp:
                return fontTypes.whatsappRegular.rawValue
                case .cometchat:
                return fontTypes.cometChatRegular.rawValue
                }
        case .bold:
            switch AppAppearance{
            case .facebook:
                return fontTypes.facebookBold.rawValue
            case .whatsapp:
                return fontTypes.whatsappBold.rawValue
            case .cometchat:
                return fontTypes.cometChatBold.rawValue
            }

        case .italic:
            switch AppAppearance{
            case .facebook:
                return fontTypes.facebookItalic.rawValue
            case .whatsapp:
                return fontTypes.whatsappItalic.rawValue
            case .cometchat:
                return fontTypes.cometChatItalic.rawValue
            }
        }
    }
}



class UIAppearanceFont {
    
    static var regular:String{
        
        return SystemFont.regular.value
    }
    
    static var bold:String{
        
        return SystemFont.bold.value
    }
    
    static var italic:String{
        
        return SystemFont.italic.value
    }
    
}


class UIAppearanceSize{
    
   static var CORNER_RADIUS:Double {

    switch AppAppearance{
        case .facebook:
            return 12.0
        case .whatsapp:
            return 0.0
        case .cometchat:
            return 20.0
        }
    }
    
    static var Padding:Double {
        
        switch AppAppearance{
            
        case .facebook:
            return 0.0
        case .whatsapp:
            return 0.0
        case .cometchat:
            return 10.0
        }
    }

}

class UIAppearanceColor{
    
    static let NAVIGATION_BAR_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "FFFFFF"
        case .whatsapp:
            return "FFFFFF"
        case .cometchat:
            return "2636BE"
        }
    }()
    
    static let NAVIGATION_BAR_TITLE_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "000000"
        case .whatsapp:
            return "000000"
        case .cometchat:
            return "FFFFFF"
        }
    }()
    
    static let NAVIGATION_BAR_BUTTON_TINT_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "0084FF"
        case .whatsapp:
            return "0084FF"
        case .cometchat:
            return "FFFFFF"
        }
    }()
    
    static let BACKGROUND_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "D9DBDD"
        case .whatsapp:
            return "25D366"
        case .cometchat:
            return "2636BE"
        }
    }()
    
    static let LOGIN_BUTTON_TINT_COLOR:String = {
        switch AppAppearance{
        case .facebook:
            return "0084FF"
        case .whatsapp:
            return "25D366"
        case .cometchat:
            return "2636BE"
        }
    }()
    
    
    static let LOGO_TINT_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "000000"
        case .whatsapp:
            return "FFFFFF"
        case .cometchat:
            return "FFFFFF"
        }
    }()
    
    static let RIGHT_BUBBLE_BACKGROUND_COLOR:String = {
        
        switch AppAppearance{
        case .facebook:
            return "0084FF"
        case .whatsapp:
            return "25D366"
        case .cometchat:
            return "2636BE"
        }
    }()
   
    }



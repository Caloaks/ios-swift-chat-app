# [iOS-swift-chat-app](https://www.cometchat.com) - Sample app which helps  to integrate CometChat pulse in you app.

CometChat-Pulse iOS Demo app made using CometChat-Pulse iOS SDK is a fully functional messaging app capable of **OnetoOne** and **Group** messaging.OnetoOne and Group messaging allows you to send **text** and various **multimedia messages like audio,video,images,documents etc..**

[![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)](https://cocoapods.org/pods/CometChatPulseSDK)
[![Languages](https://img.shields.io/badge/language-Swift-orange.svg)](https://github.com/CometChat-Pulse/ios-swift-chat-app)


## Table of Content

1. [Installation ](#installtion)

2. [Run the Sample App ](#run-the-sample-app)

3. [ScreenShots ](#screenshots)

4. [Contribute](#contribute)

## Installtion 
      
   Simply Clone the project from iOS-swift-chat-app repository. Install the CometChatPulseSDK inside your project.
   
## Install CometChatPulseSDK Framework in  your project

Add below into your Podfile on Xcode.

```
target 'CometChatPulse-swift-sampleApp' do
  
	pod 'CometChatPulseSDK'

end
```

Install CometChatPulseSDK Framework through CocoaPods.

```
pod install
```
Once the pod is installed. Update the pods to install latest SDK inside your project using below command. 

```
pod update
```

Now you can see installed CometChatPulseSDK framework by inspecting CometChatPulse-swift-sampleApp.xcworkspace.   
   
   

## Run the Sample App


   
   To Run to sample App you have to do the following changes by Adding **ApiKey** and **AppId**
          
   - Open the Project in Android Mode in Android Studio 
          
   - Go to Under CometChatPulse-swift-sampleApp -->  CCConstants.swift
          
   - Under `CCConstants.swift` file  go to `class` named `Authentication`
          
  -  modify *APP_ID* and *API_KEY* with your own **ApiKey** and **AppId**
 
       `static let APP_ID = "XXXXXXXXXX"`
        
       `static let API_KEY = "XXXXXXXXXX"`
       
       
            
## Note    


   You can Obtain your  *APP_ID* and *API_KEY* from [CometChat-Pulse Dashboard](cometchat-pulse-dashboard)
   
   For more information read [ios-chat-sdk](ios-chat-sdk) Documentation
       
   
   
     
  ![Studio Guide](https://github.com/CometChat-Pulse/ios-swift-chat-app/blob/master/Screenshots/AuthenticationClass.png)                                      
  
  
     
   
   
 
   
## ScreenShots

<img align="left" width="370" height="662" src="https://github.com/CometChat-Pulse/ios-swift-chat-app/blob/master/Screenshots/splash.gif">
   

   <img align="left" width="370" height="662" src="https://github.com/CometChat-Pulse/ios-swift-chat-app/blob/master/Screenshots/login.gif">
   
   
   <img align="left" width="370" height="662" src="https://github.com/CometChat-Pulse/ios-swift-chat-app/blob/master/Screenshots/tapOnContact.gif">
   
 
   
   <img align="left" width="370" height="662" src="https://github.com/CometChat-Pulse/ios-swift-chat-app/blob/master/Screenshots/Contacts.gif"></br>                                                      
   

   
## Contribute 
   
   
   Feel free to make any suggestion or Contribution to the App. 
   
   You can Download and Modify the Source code according to your need.
   
   Also you can start directly using the App.


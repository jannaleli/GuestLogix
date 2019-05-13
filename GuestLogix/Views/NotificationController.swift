//
//  NotificationsViewController.swift
//  GuestLogix
//
//  Created by Jann Aleli Zaplan on 12/5/19.
//  Copyright © 2019 Jann Aleli Zaplan. All rights reserved.
//

import Foundation
import SwiftMessages

class NotificationController {
    func fireErrorNotification( message: String){
        let view = MessageView.viewFromNib(layout: .messageView)
        
        // Theme message elements with the warning style.
        view.configureTheme(.error)
        
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["✈️ "].sm_random()!
        //        view.configureContent(title: "Warning", body: "No Route Exists between \(source!.name) and \(destination!.name).", iconText: iconText)
        view.configureContent(title: "Warning", body: message, iconText: iconText)
        view.button?.isHidden = true
        
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
    
    
}

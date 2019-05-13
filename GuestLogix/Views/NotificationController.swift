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
        
        view.configureTheme(.error)

        view.configureDropShadow()
        
        let iconText = ["✈️ "].sm_random()!

        view.configureContent(title: "Warning", body: message, iconText: iconText)
        
        view.button?.isHidden = true

        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        SwiftMessages.show(view: view)
        
    }
    
    
}

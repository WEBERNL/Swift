//
//  AlertMessageDatabase.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/30/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit

// this class isn't being extended from another class
class AlertMessageDatabase {
    
    // this variable is an array of Messages referenced for user alerts
    // note that each Message itself has several attributes (messageId, message, messageReference, isScripture, etc)
    var messagesFromAlertCategories: [Message] = []
        
    // these variables are associated with the messagesFromAlertCategories variable
    var messagesFromAlertCategoriesCount: Int = 0
    var randomMessageFromAlertCategories: String = ""
    var randomMessageReferenceFromAlertCategories: String = ""
    var randomInteger: Int = 0
    var alertTimeHours: Int = 0
    var alertTimeMinutes: Int = 0   
    
    
        
   
    
    
    
}

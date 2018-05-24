//
//  Message.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/11/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//


import UIKit


// this class is being extended from the NSObject class
class Message: NSObject, NSCoding {
    var messageId: Int
    var message: String
    var messageReference: String
    var isScripture: Bool
    var isQuip: Bool
    var isFavorite: Bool
    
    
    // initializing an instance of the class...parameters use the format of parameter label then parameter data type...while there is a default init() function for the NSObject, this code first modifies the default function (with specific parameters, etc), then calls the default function (via the super.init() function) to complete the initialization process
    init(messageId: Int, message: String, messageReference: String, isScripture: Bool, isQuip: Bool, isFavorite: Bool) {
        self.messageId = messageId
        self.message = message
        self.messageReference = messageReference
        self.isScripture = isScripture
        self.isQuip = isQuip
        self.isFavorite = isFavorite
        
        super.init()
    }
    
   
    // decoding data (if any) for import from persistent storage
    // this function called upon opening application
    required init(coder aDecoder: NSCoder) {
        
        let messageIdText = aDecoder.decodeObject(forKey: "messageId") as? String
        messageId = Int(messageIdText!)!
        
        message = aDecoder.decodeObject(forKey: "message") as! String
        messageReference = aDecoder.decodeObject(forKey: "messageReference") as! String
        
        let isScriptureText = aDecoder.decodeObject(forKey: "isScripture") as? String
        if isScriptureText == "false"{
            isScripture = false
        } else{
            isScripture = true
        }
        
        let isQuipText = aDecoder.decodeObject(forKey: "isQuip") as? String
        if isQuipText == "false"{
            isQuip = false
        } else{
            isQuip = true
        }
        
        let isFavoriteText = aDecoder.decodeObject(forKey: "isFavorite") as? String
        if isFavoriteText == "false"{
            isFavorite = false
        } else{
            isFavorite = true
        }
        
       
        
        super.init()
        
    }
    
    
    /*
    // decoding data (if any) for import from persistent storage
    // this function called upon opening application
    // HOWEVER, since getting errors when decoding Integer and Boolean values, using the above function instead
    
     required init(coder aDecoder: NSCoder) {
    
        messageId = aDecoder.decodeObject(forKey: "messageId") as! Int
        message = aDecoder.decodeObject(forKey: "message") as! String
        messageReference = aDecoder.decodeObject(forKey: "messageReference") as! String
        isScripture = aDecoder.decodeObject(forKey: "isScripture") as! Bool
        isQuip = aDecoder.decodeObject(forKey: "isQuip") as! Bool
        isFavorite = aDecoder.decodeObject(forKey: "isFavorite") as! Bool
    
        super.init()
     
    }
 
    */
    
    
    
    // encoding data for export to persistent storage
    // this function called upon exiting application
    func encode(with aCoder: NSCoder) {
        let messageIdText = String(messageId)
        aCoder.encode(messageIdText, forKey: "messageId")
       
        aCoder.encode(message, forKey: "message")
        aCoder.encode(messageReference, forKey: "messageReference")
        
        let isScriptureText = String(isScripture)
        aCoder.encode(isScriptureText, forKey: "isScripture")
        

        let isQuipText = String(isQuip)
        aCoder.encode(isQuipText, forKey: "isQuip")
       
        
        let isFavoriteText = String(isFavorite)
        aCoder.encode(isFavoriteText, forKey: "isFavorite")      
        
        
        
    }
    
    
    /*
    // encoding data for export to persistent storage
    // this function called upon exiting application
    // HOWEVER, since getting errors when encoding Integer and Boolean values, using the above function instead
    
     func encode(with aCoder: NSCoder) {
    
        aCoder.encode(messageId, forKey: "messageId")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(messageReference, forKey: "messageReference")
        aCoder.encode(isScripture, forKey: "isScripture")
        aCoder.encode(isQuip, forKey: "isQuip")
        aCoder.encode(isFavorite, forKey: "isFavorite")
   
    }
    */
    
}



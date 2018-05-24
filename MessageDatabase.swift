//
//  MessageDatabase.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/11/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit

// this class isn't being extended from another class
class MessageDatabase {
    
    // this variable is an array of Message instances
    // note that each Message itself has several attributes (messageId, message, messageReference, isScripture, etc)
       var allMessages : [Message] = []
    
    
	
    // creating an instance of Message and appending it to the allMessages variable
    func createMessage(messageId: Int, message: String, messageReference: String, isScripture: Bool, isQuip: Bool, isFavorite: Bool) -> Message {
        
        let message = Message(messageId: messageId, message: message, messageReference: messageReference, isScripture: isScripture, isQuip: isQuip, isFavorite: isFavorite)
		
		allMessages.append(message)
          
        
        return message
    }
    
    
	// assembling data for Message instances
    // note the call to the createMessage() function
    func initializeMessages() {
		let messageId = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
       
        let message = ["…All things are possible with God.", "Many, O LORD my God, are the wonderful works which You have done, and Your thoughts toward us…", "The LORD is near to all who call upon Him, to all who call upon Him sincerely and in truth.", "The LORD is my Shepherd, I shall not lack.", "In my distress I cried to the LORD, and He answered me.", "If any of you is deficient in wisdom, let him ask of the giving God [Who gives] to everyone liberally and ungrudgingly, without reproaching or faultfinding, and it will be given him.", "Beloved, let us love one another, for love is from God…", "Courage doesn't always roar.  Sometimes courage is the quiet voice at the end of the day, saying, I will try again tomorrow.", "The darkest night is often the bridge to the brightest tomorrow.", "Experience is the name everyone gives to their mistakes.", "There are only two ways to live your life.  One is as though nothing is a miracle.  The other is as though everything is a miracle.", "A flower is a weed seen through joyful eyes.", "Life is a reflection of intent.  Love reflects love.  Hate reflects hate.", "Whatever you do, do with kindness.  Whatever you say, say with kindness.  Wherever you go, radiate kindness.", "Personal message!"]
		
        let messageReference = ["Matthew 19: 26b", "Psalm 40: 5a", "Psalm 145: 18", "Psalm 23: 1", "Psalm 120: 1", "James 1: 5", "1 John 4: 7a", "Mary Anne Radmacher", "Jonathan Lockwood Huie", "Oscar Wilde", "Albert Einstein", "Jonathan Lockwood Huie", "Jonathan Lockwood Huie", "Jonathan Lockwood Huie", "me"]
        
        let isScripture = [true, true, true, true, true, true, true, false, false, false, false, false, false, false, false]
        
        let isQuip = [false, false, false, false, false, false, false, true, true, true, true, true, true, true, false]
		
        let isFavorite = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, true]
        
        for i in 0..<15 {
            createMessage(messageId: messageId[i], message: message[i], messageReference: messageReference[i], isScripture: isScripture[i], isQuip: isQuip[i], isFavorite: isFavorite[i])
            
            
        }
        
    }
    
    
    func getScriptureMessageCount() -> Int {
        var messageCount: Int = 0
        
        for i in 0..<allMessages.count {
            if allMessages[i].isScripture == true{
                messageCount = messageCount + 1
            }
        }
        return messageCount
        
        
    }
    
 
    func getQuipMessageCount() -> Int{
        var messageCount: Int = 0
        
        for i in 0..<allMessages.count {
            if allMessages[i].isQuip == true{
                messageCount = messageCount + 1
            }
        }
        return messageCount

        
    }
    
    
    func getFavoriteMessageCount() -> Int{
        var messageCount: Int = 0
        
        for i in 0..<allMessages.count {
            if allMessages[i].isFavorite == true{
                messageCount = messageCount + 1
            }
        }
        return messageCount
        
    }
	

   
    // getting a directory for persistent storage
    let messageArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("message.archive")
    }()
    
    // exporting allMessages array to a directory for persistent storage upon exiting application
    // this function calls the encode function in the Message class (for encoding data)
    func exportMessages(){
        let successfulExport = NSKeyedArchiver.archiveRootObject(allMessages, toFile: messageArchiveURL.path)
        if (successfulExport) {
            print("Saved all of the messages")
        }
        else {
            print("Error when attempting to save messages")
        }

        print("Saving messages to: \(messageArchiveURL.path)")
    }
    
    
    // initializing allMessages array by importing information from persistent storage upon opening application
    // this function calls the required init function in the Message class (for decoding data)
    init() {
        if let archivedMessages = NSKeyedUnarchiver.unarchiveObject(withFile: messageArchiveURL.path) as? [Message] {
            allMessages += archivedMessages
        }
       
    }
   
   

}

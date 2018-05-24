//
//  DataEntryViewController.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/16/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit

class DataEntryViewController: UIViewController, UITextViewDelegate {
    
    // this variable refers to the messages variable in the AppDelegate and is assigned a value in the viewWillAppear function
    var messages : MessageDatabase!
    
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var buttonCancelEntry: UIButton!
    @IBOutlet var buttonSaveEntry: UIButton!
    
    // referencing an instance of the MessageDatabase class that was instantiated and initialized in AppDelegate.swift
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        messages = appDelegate.messages
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        textView.delegate = self
        textView.becomeFirstResponder()
        textView.clearsOnInsertion = true
    }


    /*
    //textView is automatically first responder when the textView appears...
    //this function updates the textView's first responder status (and therefore associated keyboard visibility) if the background of the UIViewController is tapped...
    //note that a Tap Gesture Recognizer was then added to the UIViewController and "connected" to this function
    */
    @IBAction func backgroundTapped(sender: AnyObject){
        if(textView.isFirstResponder == true ){
            textView.resignFirstResponder()
        }else {
            textView.becomeFirstResponder()
        }
    }
    
    
    @IBAction func cancelMessage (sender:UIButton){
        if sender == buttonCancelEntry {
            textView.text = ""
        }
    }
    

     @IBAction func saveMessage (sender:UIButton){
        if (sender == buttonSaveEntry) {
            
            let enteredMessageId = messages.allMessages.count + 1
            let enteredMessageText = textView.text
            let enteredMessageReference = "me"
            let enteredMessageIsScripture = false
            let enteredMessageIsQuip = false
            let enteredMessageIsFavorite = true
            
            messages.createMessage(messageId: enteredMessageId, message: enteredMessageText!, messageReference: enteredMessageReference, isScripture: enteredMessageIsScripture, isQuip: enteredMessageIsQuip, isFavorite: enteredMessageIsFavorite)
            
            textView.text = ""
            
            // this code then notifies user that the personal message was saved
            let alertController = UIAlertController(title: "Notification", message: "Your message has been saved as a \"Personal Favorite\"!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)

            
        }
    }

       
    
}

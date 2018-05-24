//
//  MessagesViewController.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/11/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // this variable refers to the messages variable in the AppDelegate and is assigned a value in the viewWillAppear function
    var messages : MessageDatabase!
    
    var messagesFromCategory: [Message] = []
    var selectedMessageId: Int = 0
   
		
    @IBOutlet var buttonScripture: UIButton!
    @IBOutlet var buttonQuip: UIButton!
    @IBOutlet var buttonFavorite: UIButton!
    @IBOutlet var buttonUpdateAsFavorite: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    
    // referencing an instance of the MessageDatabase class that was instantiated and initialized in AppDelegate.swift
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        messages = appDelegate.messages
    }
    
        
    // this function is called after user selects message category
    @IBAction func viewMessagesFromCategory (sender:UIButton){
        
        if (sender == buttonScripture) {
            buttonScripture.isSelected = true
            buttonQuip.isSelected = false
            buttonFavorite.isSelected = false			           
            tableView.reloadData()
           
        }else if (sender == buttonQuip) {
            buttonQuip.isSelected = true
            buttonScripture.isSelected = false
            buttonFavorite.isSelected = false           
            tableView.reloadData()
            
        }else if (sender == buttonFavorite){
            buttonFavorite.isSelected = true
            buttonScripture.isSelected = false
            buttonQuip.isSelected = false            
            tableView.reloadData()
        }
        
    }
    
    // this function is called after user selects "updateAsFavorite"
    @IBAction func updateMessageAsFavorite (sender: UIButton ){
        if (sender == buttonUpdateAsFavorite) {
            for i in 0..<messages.allMessages.count{
                if messages.allMessages[i].messageId == selectedMessageId {
                    messages.allMessages[i].isFavorite = true
                }
            }

        }
        
        // this code then notifies user that item has been updated to "favorite" status
        let alertController = UIAlertController(title: "Notification", message: "This message is now also included as a \"Personal Favorite\"!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    // this function is called when the reloadData() function is called
    // note that since the messages variable is an instance of the MessageDatabase class, it has access to MessageDatabase functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var messageCount: Int = 0
        
        if buttonScripture.isSelected == true {
            messageCount = messages.getScriptureMessageCount()
        }
        
        if buttonQuip.isSelected == true {
            messageCount = messages.getQuipMessageCount()
        }
        
        if buttonFavorite.isSelected == true {
            messageCount = messages.getFavoriteMessageCount()
        }
         
        return messageCount
    }
 
	
	// this function is called when the reloadData() function is called, and it returns data to the UITableViewCell...
    // note the reference to the ItemTableViewCell class specifically
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // clear the messagesFromCategory variable
        messagesFromCategory = []
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
    
        // update messagesFromCategory variable depending on the category selected
        if (buttonScripture.isSelected == true){
            for i in 0..<messages.allMessages.count{
                if messages.allMessages[i].isScripture == true {
                    messagesFromCategory.append(messages.allMessages[i])
                }
            }
        }
        
        else if (buttonQuip.isSelected == true){
            for i in 0..<messages.allMessages.count{
                if messages.allMessages[i].isQuip == true {
                    messagesFromCategory.append(messages.allMessages[i])
                }
            }
        }
            
        else if (buttonFavorite.isSelected == true){
            for i in 0..<messages.allMessages.count{
                if messages.allMessages[i].isFavorite == true {
                    messagesFromCategory.append(messages.allMessages[i])
                }
            }
        }

        // this variable refers to a particular element in the messagesFromCategory array
        let item = messagesFromCategory[indexPath.row]
            
        cell.messageLabel.text = item.message
        cell.messageReferenceLabel.text = item.messageReference
        
        return cell
        
    }
    
    
    // this function is called when a user selects data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMessageId = messagesFromCategory[indexPath.row].messageId
    }
	
	
    

    // this function identifies the tableView delegate and tableView data source
    // this function also provides a default row height and allows automatic height adjustments
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    
}

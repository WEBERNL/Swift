//
//  AlertViewController.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/16/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit
import UserNotifications

class AlertViewController: UIViewController, UNUserNotificationCenterDelegate {

   
    // this variable refers to the messages variable in the AppDelegate and is assigned a value in the viewWillAppear function
    var messages : MessageDatabase!
	
    
	// this variable refers to the alerts variable in the AppDelegate and is assigned a value in the viewWillAppear function
    var alerts: AlertMessageDatabase!
  	
    
    @IBOutlet var buttonScripture: UIButton!
    @IBOutlet var buttonQuip: UIButton!
    @IBOutlet var buttonFavorite: UIButton!
    
    @IBOutlet var buttonAM: UIButton!
    @IBOutlet var buttonPM: UIButton!
    @IBOutlet var textTimeHours: UITextField!
    @IBOutlet var textTimeMinutes: UITextField!
    
    @IBOutlet var buttonCancelEntry: UIButton!
    @IBOutlet var buttonSaveEntry: UIButton!

    
    // referencing an instance of the MessageDatabase class that was instantiated and initialized in AppDelegate.swift
	// also referencing an instance of the AlertMessageDatabase class that was instantiated in AppDelegate.swift
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
        messages = appDelegate.messages
		alerts = appDelegate.alerts
	  

        
    }

    
    // this function is called after user selects alert message category/categories
    @IBAction func alertMessageCategories(sender: UIButton){
        if (sender == buttonScripture){
            if buttonScripture.isSelected == false{
                buttonScripture.isSelected = true
            }else{
                buttonScripture.isSelected = false
            }
        } else if (sender == buttonQuip) {
            if buttonQuip.isSelected == false{
                buttonQuip.isSelected = true
            }else{
                buttonQuip.isSelected = false
            }
        }else if (sender == buttonFavorite){
            if buttonFavorite.isSelected == false{
                buttonFavorite.isSelected = true
            }else{
                buttonFavorite.isSelected = false
            }
        }
    
    }
    
	// this function is called after user selects alert timing (AM/PM)
    @IBAction func alertMessageTiming(sender:UIButton){
        if sender == buttonAM {
            buttonAM.isSelected = true
            buttonPM.isSelected = false
        } else if sender == buttonPM {
            buttonPM.isSelected = true
            buttonAM.isSelected = false
        }
    }
    


    
    // this function is used to cause the keyboard to "resign" if the background of the AlertViewController is tapped...note that a Tap Gesture Recognizer was then added to the AlertViewController and "connected" to this function
    @IBAction func backgroundTapped(sender: AnyObject){
        if (textTimeHours.isFirstResponder == true ){
            textTimeHours.resignFirstResponder()
        }
		
		if (textTimeMinutes.isFirstResponder == true) {
            textTimeMinutes.resignFirstResponder()
        }

    }

    
    // this function is called after user selects the "cancel alert" option
    @IBAction func cancelAlert (sender:UIButton){
        if sender == buttonCancelEntry {
            
            
            // clear out any pending notification requests in the UNUserNotificationCenter
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            // adjust view to defaults
            buttonScripture.isSelected = false
            buttonQuip.isSelected = false
            buttonFavorite.isSelected = false
            buttonAM.isSelected = false
            buttonPM.isSelected = false
            textTimeHours.text = "00"
            textTimeMinutes.text = "00"
            
            
            
            // notify user that alert has been successfully cancelled
            let alertController = UIAlertController(title: "Notification", message: "Your alert has been cancelled.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)

		}
    }
    
	// this function is called after user selects the "save alert" option 
    @IBAction func saveAlert (sender:UIButton){
        if sender == buttonSaveEntry {
			// if data is valid, prepare data for use; otherwise, notify user that they must provide other information
            
            if (textTimeHours.text != nil && textTimeMinutes.text != nil) &&
               (buttonAM.isSelected == true || buttonPM.isSelected == true) &&
               (buttonScripture.isSelected == true || buttonQuip.isSelected == true || buttonFavorite.isSelected == true)
            {
			
			
				
                // update alertTimeHours and alertTimeMinutes variables depending on time selected by user
                // note that time data must be properly formatted first
                let numberFormat = NumberFormatter()
                let textTimeHoursNumber = Int(numberFormat.number(from: textTimeHours.text!)!)
                let textTimeMinutesNumber = Int(numberFormat.number(from: textTimeMinutes.text!)!)
				
				if buttonAM.isSelected == true {
					if textTimeHoursNumber == 12 {
						alerts.alertTimeHours = 0
						alerts.alertTimeMinutes = textTimeMinutesNumber
					}else{
						alerts.alertTimeHours = textTimeHoursNumber
						alerts.alertTimeMinutes = textTimeMinutesNumber
					}
				}else {
					if textTimeHoursNumber == 12 {
						alerts.alertTimeHours = 12
						alerts.alertTimeMinutes = textTimeMinutesNumber
					}else {
						alerts.alertTimeHours = textTimeHoursNumber + 12
						alerts.alertTimeMinutes = textTimeMinutesNumber
					}
				}
                
                           
                
                
				// update messagesFromAlertCategories array depending on alert categories selected by user
                // note that the redundantEntry variable is used to avoid redundant messages in the messagesFromAlertCategories array
				var redundantEntry = 0
                				
                if buttonScripture.isSelected == true{
                    for i in 0..<messages.allMessages.count{
                        if messages.allMessages[i].isScripture == true {
                            alerts.messagesFromAlertCategories.append(messages.allMessages[i])
                        }
                    }
                }
                
                if buttonQuip.isSelected == true{
                    for i in 0..<messages.allMessages.count{
                        if messages.allMessages[i].isQuip == true {
                            alerts.messagesFromAlertCategories.append(messages.allMessages[i])
                        }
                    }
                }

                if buttonFavorite.isSelected == true{
                    for i in 0..<messages.allMessages.count{
                        if messages.allMessages[i].isFavorite == true {
							
							redundantEntry = 0
							for x in 0..<alerts.messagesFromAlertCategories.count{
								if messages.allMessages[i].messageId == alerts.messagesFromAlertCategories[x].messageId {
									redundantEntry += 1					
								}
							}
							if redundantEntry == 0 {
							alerts.messagesFromAlertCategories.append(messages.allMessages[i])
							
							}
						}						
                    }
                }
				
                // call the function that accesses and updates members of the UNUserNotificationCenter class
                updateNotificationCenter()
                
                // notify user that alert options were saved
                let alertController = UIAlertController(title: "Notification", message: "Your alert options were successfully saved!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Close", style: .default)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)          
                
                
                
                
            }else {
                
            // notify user that alert options must be selected
                let alertController = UIAlertController(title: "Warning", message: "Remember to select alert categories and alert timing (including valid time and AM/PM).", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Close", style: .default)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)

                
            }
        }
    }
    
	
    
		// access and update members of the UNUserNotificationCenter class
		// note that the notification message must be a random MessageDatabase message (and message reference) from the category(categories) selected by user
    func updateNotificationCenter(){
       		 
        // requesting permission for notifications...once user gives ok, authorization persists and isn't requested again
		// per documentation: "The first time your app requests authorization, the user is alerted and given an opportunity to deny or grant that authorization. After the initial request, the system remembers the user’s response and returns it during subsequent requests. You must request authorization for both local and remote notifications."
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
               print("Permission given.")
            }
            else{
                print("Permission denied.")
            }
        }
      
        
       
        // specifying the notification timing
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = alerts.alertTimeHours
        dateComponents.minute = alerts.alertTimeMinutes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        
		// specifying the notification message by calling the selectNotificationMessage() function
        let content = UNMutableNotificationContent()
        content.title = "A little ENCOURAGEMENT!"
        content.body = selectNotificationMessage()
        content.sound = UNNotificationSound.default()
        
        
        
        let identifier = "UserAlertMessage"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        // calling the add() function to add the notification request to the UNUserNotificationCenter
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
        // clearing the AlertMessageDatabase instance (after alert established) by calling the clearAlertMessageDatabase() function
        clearAlertMessageDatabase()
        
    }
	
	
	// specify the notification message    
    func selectNotificationMessage() -> String {        
        alerts.messagesFromAlertCategoriesCount = alerts.messagesFromAlertCategories.count       
        
        alerts.randomInteger = Int(arc4random_uniform(UInt32(alerts.messagesFromAlertCategoriesCount)))
        
        alerts.randomMessageFromAlertCategories = alerts.messagesFromAlertCategories[alerts.randomInteger].message
        
        alerts.randomMessageReferenceFromAlertCategories = alerts.messagesFromAlertCategories[alerts.randomInteger].messageReference
        return "\(alerts.randomMessageFromAlertCategories)" + " --- " + "\(alerts.randomMessageReferenceFromAlertCategories)"
    }

		
		
    // clear the AlertMessageDatabase instance by adjusting member variables to default values
    func clearAlertMessageDatabase(){
        alerts.messagesFromAlertCategories = []
        alerts.messagesFromAlertCategoriesCount = 0
        alerts.randomMessageFromAlertCategories = ""
        alerts.randomMessageReferenceFromAlertCategories = ""
        alerts.randomInteger = 0
        alerts.alertTimeHours = 0
        alerts.alertTimeMinutes = 0
    }
    
    
    
    
}

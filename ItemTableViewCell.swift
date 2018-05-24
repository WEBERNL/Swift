//
//  ItemTableViewCell.swift
//  Encouragement App
//
//  Created by Weber, Nancy L on 4/11/18.
//  Copyright © 2018 Weber, Nancy L. All rights reserved.
//

import UIKit

// this class is being extended from the UITableViewCell class
// the purpose of this class is that of customizing cells (font color, font size, etc) within the UITableView instead of defaulting to "standard" cells
// note that the UITableViewCell area within the storyboard was "customized" by adding and formatting several labels, identifying the associated custom class (as, in this example, the ItemTableViewCell class) via the Identity Inspector, and specifying the identifier (as, in this example, ItemCell) via the Attributes Inspector
// this class, then, establishes variables to "connect" with the customized labels via the Connections Inspector
class ItemTableViewCell: UITableViewCell {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageReferenceLabel: UILabel!
    

    
    
}


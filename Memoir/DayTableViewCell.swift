//
//  DayTableViewCell.swift
//  Memoir
//
//  Created by Namrata Mohanty on 12/1/16.
//
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

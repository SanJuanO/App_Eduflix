//
//  NotificacionesTableViewCell.swift
//  Eduflix
//
//  Created by Oscar San juan on 18/06/21.
//

import UIKit

class NotificacionesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var titulo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

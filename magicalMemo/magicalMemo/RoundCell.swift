//
//  RoundCell.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/05.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit

class RoundCell: UITableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var createMonthLabel: UILabel!
    @IBOutlet weak var createDayLabel: UILabel!
    @IBOutlet weak var uploadDayLabel: UILabel!
    
    @IBOutlet weak var memoLabel: UILabel!
    
    @IBOutlet weak var abstLabel: UILabel!
    
    @IBOutlet weak var figureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

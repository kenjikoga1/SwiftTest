//
//  RoundCell.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/05.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit

class RoundCell: UITableViewCell {
    
    
    @IBOutlet weak var round: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createDayLabel: UILabel!
    @IBOutlet weak var uploadDayLabel: UILabel!
    
    @IBOutlet weak var memoLabel: UILabel!
    
    @IBOutlet weak var abstLabel: UILabel!
    
    @IBOutlet weak var figureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        round.layer.cornerRadius = 20
//        cellView.layer.cornerRadius = 10
//
//        self.cellView.layer.shadowOpacity = 0.2
//        self.cellView.layer.shadowRadius = 10
//        self.cellView.layer.shadowColor = UIColor.black.cgColor
//        self.cellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

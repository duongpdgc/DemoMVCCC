//
//  TableCell.swift
//  SearchBarInTable
//
//  Created by PhamDucDuong on 1/13/18.
//  Copyright © 2018 PhamDucDuong. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet weak var h_ratings: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

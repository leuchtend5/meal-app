//
//  TableViewCell.swift
//  MyMealsApp
//
//  Created by Gilbert Tan on 02/09/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealImage: DownloadImage!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mealImage.layer.cornerRadius = mealImage.frame.size.width / 2
        mealImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  FavoritesTableViewCell.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 9.03.2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

   
    
   
   
    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

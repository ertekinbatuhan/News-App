//
//  TitleCollectionViewCell.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 30.04.2024.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    
    public func configure(with model : String){
       
       guard let url = URL(string: model) else {
            return
        }
        posterImageView.sd_setImage(with: url,completed: nil)
     
      
    }
    
}

//
//  HeroHeaderUIView.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 30.04.2024.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    private let heroImageView  : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "currentnews")
        
        return imageView
    }()
    
    private func addGradient(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
         
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
      //  addGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        heroImageView.layer.cornerRadius = 12
        heroImageView.layer.masksToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}

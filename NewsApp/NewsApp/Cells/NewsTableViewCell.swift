//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 26.02.2024.
//

import UIKit

class NewsTableViewCellViewModel {
    let title : String
    let subTitle : String
    let imageURL : URL?
    var imageData : Data? = nil
    
    init(title: String, subTitle: String, imageURL: URL?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
       
    }
}

class NewsTableViewCell: UITableViewCell {

    static let identifier = "newsCell"
    
    private let newsTitleLabel :  UILabel  = {
        let label = UILabel()
        label.numberOfLines = 0
        
        
        label.font = .systemFont(ofSize: 25,weight: .semibold)
        return label
         
    }()
    
    private let subTitleLabel :  UILabel  = {
        let label = UILabel()
        label.numberOfLines = 0
        
        label.font = .systemFont(ofSize: 17,weight: .regular)
        return label
         
    }()
    
    private let  newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor  = .secondarySystemBackground
        imageView.contentMode = . scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 179, height: 70)
        
        subTitleLabel.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 170, height: contentView.frame.size.height / 2)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width-150, y: 5 , width: 150, height: contentView.frame.size.height - 10 )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subTitleLabel.text = nil
        newsImageView.image = nil 
        
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel ) {
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        if let data = viewModel.imageData  {
            
            newsImageView.image = UIImage(data : data)
        } else if let url = viewModel.imageURL {
            
            
            URLSession.shared.dataTask(with: url , completionHandler: { [weak self] data , response , error  in
            
                guard let data = data  , error == nil  else {
                    
                    return
                    
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
                
            }).resume()
            
        }
    }
}

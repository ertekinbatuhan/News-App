//
//  TestTableViewCell.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 30.04.2024.
//

import UIKit
import SafariServices

protocol StoriesTableViewCellProtokol: AnyObject {
    func didSelectNews(url: URL)
}


class StoriesTableViewCell: UITableViewCell {
    
    weak var delegate: StoriesTableViewCellProtokol?

    static let identifier = "StoriesTableViewCell"
    
    private var getNews : [News] = [News]()
    
    var viewModels = [NewsTableViewCellViewModel]()
    

    private let collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140 ,height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
       return collectionView
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    public func configure(with news : [News]){
        self.getNews = news
        
        DispatchQueue.main.async{ [weak self] in
            self?.collectionView.reloadData()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

}

extension StoriesTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.row < getNews.count else {
                return UICollectionViewCell()
            }
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let model  = getNews[indexPath.row].urlToImage {
                cell.configure(with: model)
            } else {
             
            }
            
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let getNews = getNews[indexPath.row]
        
        guard let url = URL(string: getNews.url ?? "") else {
               return
           }
          
         delegate?.didSelectNews(url: url)
           
       }
}

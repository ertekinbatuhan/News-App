//
//  CategoryVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 16.04.2024.
//

import UIKit

class CategoryVC: UIViewController {

    var categoryList = [Category]()
    let  categoryViewModel = CategoryViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryViewModel.databaseCopy()
        
        //  databaseCopy()
       
        categoryList = CategoryDao().allCategory()
        
        collectionView.dataSource = self
        collectionView.delegate = self
      
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = self.collectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.6)
        
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = design
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        let goToVC = segue.destination as! NewsSqlVC
       goToVC.category = categoryList[index!]
    }
     
}

extension CategoryVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category = categoryList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryLabel.text = category.category_name
        cell.categoryImageView.image = UIImage(named: category.category_image)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetailNews", sender: indexPath.row)
    }
        
}

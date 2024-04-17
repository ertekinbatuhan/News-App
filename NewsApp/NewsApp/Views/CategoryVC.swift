//
//  CategoryVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 16.04.2024.
//

import UIKit

class CategoryVC: UIViewController {

    
    var categoryList = [Category]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       databaseCopy()
        // Do any additional setup after loading the view.
        
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
    
    
    func databaseCopy(){
        
        let bundleWay = Bundle.main.path(forResource: "news", ofType: ".sqlite")
        
        let targetWay = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let copyLocation = URL(fileURLWithPath: targetWay).appendingPathComponent("news.sqlite")
        
        if fileManager.fileExists(atPath: copyLocation.path) {
            print("the database already exists")
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleWay!, toPath: copyLocation.path)
                
            }catch{
                print(error)
            }
        }
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
        
        self.performSegue(withIdentifier: "toTest", sender: indexPath.row)
    }
        
}

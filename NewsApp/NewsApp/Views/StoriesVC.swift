//
//  TestVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 30.04.2024.
//

import UIKit
import SafariServices

enum Sections : Int {
    
    case Everything = 0
    case Business = 1
    case Technology = 2
    case Sports = 3
    case Entertainment = 4
    case Science = 5
    case General = 6
   
}

class StoriesVC: UIViewController {
   
    let sectionTitles  : [String] = ["Everything", "Business", "Technology", "Sports", "Entertainment","Science","General"]
    private let testTableView  : UITableView = {
       
        
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(StoriesTableViewCell.self, forCellReuseIdentifier: StoriesTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testTableView)
        view.backgroundColor = .systemBackground
       
        // Do any additional setup after loading the view.
        
        testTableView.dataSource = self
        testTableView.delegate = self
        
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        testTableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        testTableView.frame = view.bounds
    }

}


extension StoriesVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoriesTableViewCell.identifier, for: indexPath) as? StoriesTableViewCell  else {
            return UITableViewCell()
            
           
        }
        
        cell.delegate = self
        
        
        DispatchQueue.global(qos: .background).async {
                switch indexPath.section {
                case Sections.Entertainment.rawValue:
                    APICaller.shared.getEntertainmentStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.Everything.rawValue:
                    APICaller.shared.getTopStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                              
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.Sports.rawValue:
                    APICaller.shared.getSportsStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.Technology.rawValue:
                    APICaller.shared.getTechnologyStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                               
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.Business.rawValue:
                    APICaller.shared.getBusinessStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                case Sections.General.rawValue:
                    APICaller.shared.getGeneralStrories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Sections.Science.rawValue:
                    APICaller.shared.getScienceStories { result in
                        switch result {
                        case.success(let titles):
                            DispatchQueue.main.async {
                                cell.configure(with: titles)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                default:
                    break
                }
            }
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        
        
        
        header.textLabel?.textColor  = .black
        
        
        
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
}

extension StoriesVC: StoriesTableViewCellProtokol {
    func didSelectNews(url: URL) {
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}

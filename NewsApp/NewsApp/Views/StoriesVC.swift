//
//  TestVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 30.04.2024.
//

import UIKit
import SafariServices

enum Sections: Int, CaseIterable {
    case General = 0
    case Business
    case Technology
    case Sports
    case Entertainment
    case Science
}

class StoriesVC: UIViewController {
    
    private let viewModel = StoriesViewModel()
    let sectionTitles  : [String] = ["General", "Business", "Technology", "Sports", "Entertainment","Science",]
    private let testTableView  : UITableView = {
       
        
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(StoriesTableViewCell.self, forCellReuseIdentifier: StoriesTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testTableView)
        view.backgroundColor = .systemBackground
       
        viewModel.reloadTableView = { [weak self] in
                    self?.testTableView.reloadData()
                }
        
        testTableView.dataSource = self
        testTableView.delegate = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        testTableView.tableHeaderView = headerView
        
        for section in Sections.allCases {
                    viewModel.fetchStories(for: section)
                }
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
        if let news = viewModel.stories[indexPath.section] {
                    cell.configure(with: news)
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
    
        return viewModel.sectionTitles[section]
    }
    
}

extension StoriesVC: StoriesTableViewCellProtokol {
    func didSelectNews(url: URL) {
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
}

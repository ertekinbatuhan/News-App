import Foundation

class StoriesViewModel {
    var sectionTitles: [String] = ["General", "Business", "Technology", "Sports", "Entertainment", "Science"]
    var stories: [Int: [News]] = [:] // Her bölüm için News nesnelerini tutacak bir sözlük
    var reloadTableView: (() -> Void)?

    func fetchStories(for section: Sections) {
        print("Fetching stories for section: \(section)")
        switch section {
        case .Entertainment:
            APICaller.shared.getEntertainmentStories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        case .Sports:
            APICaller.shared.getSportsStories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        case .Technology:
            APICaller.shared.getTechnologyStories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        case .Business:
            APICaller.shared.getBusinessStories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        case .General:
            APICaller.shared.getGeneralStrories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        case .Science:
            APICaller.shared.getScienceStories { [weak self] result in
                self?.handleResult(result, for: section)
            }
        }
    }

    private func handleResult(_ result: Result<[News], Error>, for section: Sections) {
        switch result {
        case .success(let news):
            print("Fetched \(news.count) stories for section: \(section)")
            stories[section.rawValue] = news
            DispatchQueue.main.async {
                self.reloadTableView?()
            }
        case .failure(let error):
            print("Failed to fetch stories for section: \(section), error: \(error.localizedDescription)")
        }
    }
}


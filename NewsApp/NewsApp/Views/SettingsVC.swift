import UIKit
import Firebase

struct Section {
    let title : String
    let options : [SettingsOptionType]
}

enum SettingsOptionType{
    case staticCell(model : SettingsOption)
    case switchCell(model : SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title : String
    let icon : UIImage?
    let iconBackgroundColor : UIColor
    let handler : (() -> Void)?
    var  isOn : Bool {
        didSet{
            handler?()
        }
    }
}

struct SettingsOption {
    
    let title : String
    let icon : UIImage?
    let iconBackgroundColor : UIColor
    let handler : (() -> Void)
}


class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero , style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        
        
        return table
    }()
    
    var models = [Section]()
    
    
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        
        title = "Settings"
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }
    
    func configure(){
        
        
        models.append(Section(title: "General", options: [
        
            .switchCell(model:SettingsSwitchOption(title: "Dark Mode", icon: UIImage(systemName: "paperplane.fill"), iconBackgroundColor: .darkGray, handler: {
            
            }, isOn: false)),
            
            ]))
        
        models.append(Section(title: "Favorites", options: [
            
            .staticCell(model: SettingsOption(title: "Favorites", icon:UIImage(systemName: "heart.fill"),iconBackgroundColor: .systemRed){
                    
               
                self.performSegue(withIdentifier: "toFavorites", sender: nil)
                }),
            
        ]))
        
        
        models.append(Section(title: "General", options: [
            
            .staticCell(model: SettingsOption(title: "Wifi", icon:UIImage(systemName:"wifi"),iconBackgroundColor: .link){
                    
                }),
            
                
                .staticCell(model: SettingsOption(title: "Airplane Mode", icon: UIImage(systemName:"airplane"), iconBackgroundColor: .systemOrange){
                    
                }),
            
                .staticCell(model: SettingsOption(title: "iCloud", icon: UIImage(systemName:"cloud"), iconBackgroundColor: .systemPink){
                    
                }),
        ]))
        
    }
    

    func numberOfSections(in tableView : UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else{
                 return UITableViewCell()
             }
             
             cell.configure(with: model)
             return cell
        case .switchCell(let model):
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else{
                 return UITableViewCell()
             }
             
             cell.configure(with: model)
             return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type  = models[indexPath.section].options[indexPath.row]
        

        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler?()
        }
    }
    
    func tableView(_tableView: UITableView, titleForHeaderInSection section : Int) -> String? {
    
       
        return models[section].title
        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
            
        }catch {
            print("Failed to log out")
        }
        
    }

}

    

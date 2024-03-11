import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = ThemeManager.shared.isDarkModeEnabled
    
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
            
        }catch {
            print("Failed to log out")
        }
        
        
        
    }
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
          
            ThemeManager.shared.isDarkModeEnabled = sender.isOn
        }    
}

    

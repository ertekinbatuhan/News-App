import UIKit





class SettingsVC: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = ThemeManager.shared.isDarkModeEnabled
    
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged(_:)), for: .valueChanged)
    }
    
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
            // Dark mode switch'in değeri değiştiğinde ThemeManager'da güncelle
            ThemeManager.shared.isDarkModeEnabled = sender.isOn
        }    
}

    

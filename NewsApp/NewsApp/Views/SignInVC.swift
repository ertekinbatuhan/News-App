//
//  SignUpVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 8.03.2024.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackground()
        emailText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        passwordText.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        
        emailText.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 235/255.0,green: 235/255.0,
                                                                                                                                           blue: 245.0/255.0,alpha:0.6)])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 235/255.0,green: 235/255.0,
                                                                                                                                              blue: 245.0/255.0,alpha: 0.6)])
    }

    func setGradientBackground() {
        let colorTop = UIColor(red: 132.0/255.0, green: 104.0/255.0, blue: 212.0/255.0 , alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 39.0/255.0, green: 16.0/255.0, blue: 107.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop , colorBottom]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        if let email = emailText.text , let password = passwordText.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { result , error in
        
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
        }
    }
}

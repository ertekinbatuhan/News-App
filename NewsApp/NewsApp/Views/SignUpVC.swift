//
//  LoginVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 8.03.2024.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       setGradientBackground()
        
        userNameTextField.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        passwordTextField.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        emailTextField.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 235/255.0,green: 235/255.0,
                                                                                                                                           blue: 245.0/255.0,alpha: 0.6)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 235/255.0,green: 235/255.0,
                                                                                                                                              blue: 245.0/255.0,alpha:0.6)])
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username",attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 235/255.0,green: 235/255.0,
                                                                                                                                              blue: 245.0/255.0,alpha:0.6)])
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
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if let userEmail = emailTextField.text , let password = passwordTextField.text , let name = userNameTextField.text{
            
            Auth.auth().createUser(withEmail: userEmail, password: password) { result , error in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                } else {
                    print("sign up is succesfull")
                    self.performSegue(withIdentifier: "toNewsVC", sender: nil)
                }
            }
        }
    }
}

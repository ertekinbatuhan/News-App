//
//  NewsAIVC.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 12.05.2024.
//

import UIKit
import GoogleGenerativeAI

class NewsAIVC: UIViewController {

    let model = GenerativeModel(name: "gemini-pro",apiKey: APIKey.default)
    
    @IBOutlet weak var newsAIView: UIImageView!
    @IBOutlet weak var newsAITextField: UITextField!
    @IBOutlet weak var newsAILabel: UILabel!
    
    var textInput = "" {
            didSet {
                newsAITextField.text = textInput
            }
        }
        
        var aiResponse = "Hello! How can I help you today?" {
            didSet {
                newsAILabel.text = aiResponse
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsAILabel.text = aiResponse
        
    }
    

    @IBAction func newsAIButton(_ sender: Any) {
        
        sendMessage()
    }
    
    func sendMessage() {
        guard let inputText = newsAITextField.text, !inputText.isEmpty else {
            
            return
        }
        Task {
            do {
                let response = try await model.generateContent(inputText)
                
                guard let text = response.text else  {
                    aiResponse = "Sorry, I could not process that.\nPlease try again."
                    return
                }
                
                textInput = ""
                aiResponse = text
                
            } catch {
                aiResponse = "Something went wrong!\n\(error.localizedDescription)"
            }
        }
    }
}

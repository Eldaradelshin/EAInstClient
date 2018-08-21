//
//  ViewController.swift
//  EAInstClient
//
//  Created by rushan adelshin on 21.08.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    struct API {
        static let host = "https://api.instagram.com/v1"
        static let token = "?access_token="
        
        static func URLFor(apiMethod: String, token: String)-> String {
            return self.host + apiMethod + self.token + token
        }
    }

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       userNameLabel.text = "loading.."
        getUser()
    }

    func getUser() {
        guard let token = Credential.token else {
            return
        }
        
        APIManager.shared.load(API.URLFor(apiMethod: "/users/self", token: token)) {[weak self] (result) in
            print(result)
            guard let result = (result as? [String: Any])?["data"] as? [String: Any] else {
                DispatchQueue.main.async {
                self?.userNameLabel.textColor = UIColor.red
                self?.userNameLabel.text = "Error"
                }
                return
            }
            let user = User.init(dictionary: result)
            DispatchQueue.main.async {
            self?.userNameLabel.textColor = UIColor.green
            self?.userNameLabel.text = "\(user.userName)"
            }
            }
    }
    
    
    
}


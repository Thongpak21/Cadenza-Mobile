//
//  ViewController.swift
//  Autolayout
//
//  Created by Thongpak on 9/24/2558 BE.
//  Copyright © 2558 Thongpak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    var loggedInUser:User? { didSet { updateUI() } }
    var secure:Bool = false {didSet { updateUI() } }
    func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secure Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        imageView.image = loggedInUser?.image
    }
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", passwd: passwordField.text ?? "")
    }
}

extension User {
    var image:UIImage {
        if let image = UIImage(named:login) {
            return image
        } else {
            return UIImage(named: "Unknown_user")!
        }
    }
}
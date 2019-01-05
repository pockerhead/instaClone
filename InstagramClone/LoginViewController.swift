//
//  ViewController.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if APItoken != nil {
            let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
            UIApplication.shared.keyWindow?.rootViewController = tabbar
            present(tabbar!, animated: true, completion: nil)
        }
    }

    @IBAction func didSelectLoginButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.URL = instagramURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



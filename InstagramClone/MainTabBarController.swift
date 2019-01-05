//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by Артём Балашов on 05/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: - ViewController-based statusBar appearance
    var statusBarIsHidden: Bool = true {
        didSet {
            self.animatableUpdateStatusBarAppearance()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return statusBarIsHidden
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        statusBarIsHidden = false
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        statusBarIsHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

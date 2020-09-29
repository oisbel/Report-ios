//
//  ViewController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 12/11/19.
//  Copyright © 2019 SCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ManageUserData().IsUserDataStoraged(){
            // ir al mainTabBar
            let mainTB = self.storyboard?.instantiateViewController(identifier: "mainTapBar") as! MainTabBarController
            mainTB.modalPresentationStyle = .fullScreen
            self.present(mainTB, animated: true)
        }
    }

}


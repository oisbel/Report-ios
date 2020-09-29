//
//  MainTabBarController.swift
//  Reportes
//
//  Created by Oisbel Simpson on 5/20/20.
//  Copyright © 2020 SCC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

    }
 
}

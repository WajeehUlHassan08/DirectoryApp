//
//  ViewController.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        
        let vc1 = UINavigationController(rootViewController: PeopleViewController())
        let vc2 = UINavigationController(rootViewController: RoomsViewController())
        
        vc1.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person"), tag: 1)
        vc2.tabBarItem = UITabBarItem(title: "Rooms", image: UIImage(systemName: "bed.double.fill"), tag: 1)
            
        setViewControllers([vc1, vc2], animated: true)
        
    }


}


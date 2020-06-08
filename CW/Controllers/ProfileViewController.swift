//
//  ProfileViewController.swift
//  CW
//
//  Created by Егор on 17.05.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.tintColor = .init(white: 100, alpha: 100)

        let btnSettings = UIBarButtonItem(title:"Изменить", style: .plain, target: self, action: #selector(goToSettings))
        navigationItem.rightBarButtonItem = btnSettings
        
        btnSettings.tintColor = .white
    }
    
    
    @objc func goToSettings() {
        
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
    }
    
 

}

//
//  ChatViewController.swift
//  CW
//
//  Created by Егор on 07.06.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import Foundation
import UIKit


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.rowHeight = 84
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Игорь Кузнецов"
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont(name:"Helvetica Neue Bold", size: 22)
        cell.imageView?.image = #imageLiteral(resourceName: "s1200")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = AnotherChatViewController()
        vc.title = "Игорь Кузнецов"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
//  ViewController.swift
//  CW
//
//  Created by Егор on 07.05.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ViewController: UIViewController {
    
    var db:Firestore!
    
    let idCell = "cellF"
    
    var postsArray = [Post]()

    
    @IBAction func newPost(_ sender: Any) {
        
        let composeAlert = UIAlertController(title: "Новое задание", message: "Заполните все поля", preferredStyle: .alert)
        
        composeAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "Ваше имя"
        }
        
        composeAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "Ваш район"
        }
        
        composeAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "Задание"
        }
        
        composeAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "Оплата"
        }
        
        composeAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        composeAlert.addAction(UIAlertAction(title: "Отправить", style: .default, handler:
            { (action:UIAlertAction) in
                
                if let name = composeAlert.textFields?[0].text, let district = composeAlert.textFields?[1].text, let content = composeAlert.textFields?[2].text, let payment = composeAlert.textFields?[3].text {
                    let newPost = Post(name: name, district: district, content: content, payment: payment, timeStamp: Date())
                    
                    var ref:DocumentReference? = nil
                    ref = self.db.collection("posts").addDocument(data: newPost.dictionary) {
                        error in
                        
                        if let error = error {
                            print("Ошибка создания: \(error.localizedDescription)")
                        } else{
                            print("Создано с ID: \(ref!.documentID)")
                        }
                        }
                }
                
                
                
        }))
        
        self.present(composeAlert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        loadData()
        checkForUpdates()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CWTableViewCellCode.self, forCellReuseIdentifier: idCell)
       
        //let search = UISearchController(searchResultsController: nil)
        //search.searchResultsUpdater = self
        //self.navigationItem.searchController = search
        
        }
    
    func loadData() {
        db.collection("posts").getDocuments() {
            querySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                self.postsArray = querySnapshot!.documents.flatMap({Post(dictionary : $0.data())})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func checkForUpdates() {
        db.collection("posts").whereField("timeStamp", isLessThan: Date())
            .addSnapshotListener {
                querySnapshot, error in
                
                guard let snapshot = querySnapshot else {return}
                
                snapshot.documentChanges.forEach{
                    diff in
                    
                    if diff.type == .added {
                        if let newPost = Post(dictionary: diff.document.data()) {
                            self.postsArray.append(newPost)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        else {
                            print("error")
                        }
                    }
                    }
                }
        }
    }

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! CWTableViewCellCode
        
        let post = postsArray[indexPath.row]
        
        cell.configure(post.name, post.district, post.payment, post.content)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250.0
    }
    
}


//extension ViewController: UISearchResultsUpdating {
    //func updateSearchResults(for searchController: UISearchController) {
         
    //}
    
    
    
//}


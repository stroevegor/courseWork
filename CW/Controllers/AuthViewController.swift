//
//  AuthViewController.swift
//  CW
//
//  Created by Егор on 17.05.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import UIKit
import Firebase


class AuthViewController: UIViewController {

   var signup:Bool = true {
          willSet {
              if newValue{
                titleLabel.text = "Регистрация"
                nameSurname.isHidden = false
                doUHaveAcc.text = "У вас уже есть аккаунт?"
                enterBtn.setTitle("Войти",for: .normal)
                  
              } else{
                titleLabel.text = "FindWork"
                deskLabel.text = nil
                nameSurname.isHidden = true
                doUHaveAcc.text = "У вас ещё нет аккаунта?"
                enterBtn.setTitle("Зарегистрироваться", for: .normal)
                
                  
                  
              }
          }
      }
        

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deskLabel: UILabel!
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var doUHaveAcc: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSurname.delegate = self
        loginField.delegate = self
        passField.delegate = self

        
    }
    
    
    @IBAction func switchLogin(_ sender: Any) {
        signup = !signup
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style:  .default, handler: nil))
        present(alert, animated:true, completion: nil)
        
    }
    


}

extension AuthViewController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameSurname.text!
        let login = loginField.text!
        let password = passField.text!
        
        if (signup){
            if (!name.isEmpty && !login.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: login, password: password) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                         
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email" : login])
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                    }
                }
                       
            }else{
            showAlert()
            }
            
        }else {
            
                if (!login.isEmpty && !password.isEmpty) {
                    Auth.auth().signIn(withEmail: login, password: password) { (result, error) in
                        if error == nil {
                            self.dismiss(animated: true, completion: nil)
                        
                        }
                            
                    }
                }else{
                showAlert()
            }
        }
                
        return true
    }
    
 }




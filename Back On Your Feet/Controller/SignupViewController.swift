//
//  SignupViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 29/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//
import SVProgressHUD
import UIKit
import FirebaseAuth
class SignupViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.layer.borderWidth = 3
        passwordTextField.layer.borderWidth = 3
        nameTextField.layer.borderWidth = 3

        
       emailTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Creating....")
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if error == nil {
                SVProgressHUD.dismiss()
self.performSegue(withIdentifier: "signupToMain", sender: self)
            }
            else{
                SVProgressHUD.dismiss()

                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
   }
}

extension UIViewController{
    func alertController(for title:String,with message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)

    }
}

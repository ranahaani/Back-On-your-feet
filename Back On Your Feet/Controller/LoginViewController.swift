//
//  LoginViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 29/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginAction(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Logining...")
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
           if error == nil{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "signinToMain", sender: self)
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//
//  FeedbackViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 17/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import FirebaseFirestore
class FeedbackViewController: UIViewController {
    let userid = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    @IBOutlet weak var feedBackButtonPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedBackButtonPressed.layer.cornerRadius = 5
        feedBackButtonPressed.layer.masksToBounds = true
        feedBackButtonPressed.addTarget(self, action: #selector(feedBackButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    @objc func feedBackButtonPressed(_ sender:UIButton){
        let alertVC = UIAlertController(title: "User Feedback", message: "Did you follow up diet plan?", preferredStyle: .alert)
        alertVC.view.backgroundColor = #colorLiteral(red: 0.1997678876, green: 0.4631895423, blue: 0.615168035, alpha: 1)
        alertVC.addTextField { (aligmentTextFiled) in
            aligmentTextFiled.placeholder = "Yes or No"
        }
        alertVC.addTextField { (aligmentTextFiled) in
            aligmentTextFiled.placeholder = "How much you loss weight?"
        }
        alertVC.addTextField { (aligmentTextFiled) in
            aligmentTextFiled.placeholder = "How much you gain weight?"
        }
        
        let doneButton = UIAlertAction(title: "Add", style: .default) { (_) in
            if let input = alertVC.textFields![0].text{
                if input == "yes"{
                    
                    if let input1 = alertVC.textFields![0].text{
                        self.db.collection("profileInfo").document(self.userid!).setData( [
                            "weightloss": input1
                        ]) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                SVProgressHUD.showSuccess(withStatus: "Document added")
                                print("Document added with ")
                            }
                        }
                        
                        
                    }
                    if let input2 = alertVC.textFields![0].text{
                        self.db.collection("profileInfo").document(self.userid!).setData( [
                            "weightgain": input2,
                            
                            ]) { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    
                                    print("Document added with ")
                                }
                        }
                    }
                }
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancelButton)
        alertVC.addAction(doneButton)
        
        present(alertVC,animated: true,completion: nil)
    }
    

}

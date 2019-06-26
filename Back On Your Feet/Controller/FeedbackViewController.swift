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
    @IBOutlet weak var yesButtonPressed: UIButton!
    @IBOutlet weak var noButtonPressed: UIButton!
    @IBOutlet weak var howMuchLabel: UILabel!
    @IBOutlet weak var howMuchTextFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        howMuchLabel.isHidden = true
        howMuchTextFIeld.isHidden = true
        noButtonPressed.addTarget(self, action: #selector(noButtonPressed(_:)), for: .touchUpInside)
        yesButtonPressed.addTarget(self, action: #selector(feedBackButtonPressed(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func noButtonPressed(_ sender:UIButton){
        ShowAlert(title: "Disclaimer", message: "Please First choose diet plan")
    }
    
    @objc func feedBackButtonPressed(_ sender:UIButton){
        
        howMuchLabel.isHidden = false
        howMuchTextFIeld.isHidden = false
        
//            self.db.collection("profileInfo").document(self.userid!).setData( [
//                "weightloss": howMuchTextFIeld.text!
//            ]) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    SVProgressHUD.showSuccess(withStatus: "Document added")
//                    print("Document added with ")
//                }
//            }

    }
    

}

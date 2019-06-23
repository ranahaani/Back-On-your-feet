//
//  GetDietPlansViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 03/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD
import FirebaseAuth
class HomeViewController: UIViewController {
   // @IBOutlet weak var startJogging: UIButton!
   // @IBOutlet weak var startPushups: UIButton!
    //@IBOutlet weak var weightLoss: UIButton!
    //@IBOutlet weak var weightGain: UIButton!
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("profileInfo").document(uid!)
        SVProgressHUD.show(withStatus: "Loading...")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                SVProgressHUD.dismiss()
                if dataDescription.contains("weight loss") {
                    
                }
                else if dataDescription.contains("weight gain") {
                    
                }
            } else {
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Document does not exist")
              
                print("Document does not exist")
            }
        }
        

        
    }
    
    
    

}



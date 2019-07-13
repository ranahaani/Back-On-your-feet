//
//  WeightLossGainViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 12/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD
import FirebaseAuth
class WeightLossGainViewController: UIViewController {
    var selectedWeight = ""
    var currentAilment = ""
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("profileInfo").document(uid!)
        SVProgressHUD.show(withStatus: "Loading...")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                self.currentAilment = dataDescription?["currentAilment"] as! String
                print(self.currentAilment)
                SVProgressHUD.dismiss()
                
                
                
            } else {
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Document does not exist")
                
                print("Document does not exist")
            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func weightGainPressed(_ sender: UIButton) {
        selectedWeight = "Weight Gain"
        performSegue(withIdentifier: "toDailyDietPlan", sender: nil)
    }
    
    @IBAction func WeightLossButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toDailyDietPlan", sender: nil)
        selectedWeight = "Weight Loss"
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDailyDietPlan"{
            if let vc = segue.destination as? DailyDietPlanViewController{
                vc.selectedWeight = selectedWeight
                vc.selectedCurrentAIlment = currentAilment 


                
            }
        }
    }
 

}

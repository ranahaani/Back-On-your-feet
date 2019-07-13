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
    let bgImage:UIImageView={
       let image = UIImageView()
        image.image = UIImage(named: "bgImage")
        image.alpha = 0.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(bgImage)
        bgImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.sendSubviewToBack(bgImage)
//        let uid = Auth.auth().currentUser?.uid
//        let docRef = db.collection("profileInfo").document(uid!)
//        SVProgressHUD.show(withStatus: "Loading...")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                self.currentAilment = dataDescription?["currentAilment"] as! String
//                print(self.currentAilment)
//                SVProgressHUD.dismiss()
//
//
//
//            } else {
//                SVProgressHUD.dismiss()
//                SVProgressHUD.showError(withStatus: "Document does not exist")
//
//                print("Document does not exist")
//            }
//        }
        

        
    }
    
    
    

}



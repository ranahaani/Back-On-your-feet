//
//  SettingsViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 04/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD
import FirebaseAuth
import FirebaseAuth
class SettingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,currentAilmentDelegate,PhysicalyActivityDelegate,GenderDelegate {
    
    var currentAilment:String?
    var gender:String?
    var physicalActivitys:String?
    @IBOutlet weak var disPlayNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    var ref: DocumentReference? = nil
    var settingsdata:[String:Any] = ["Ailment":"H"]
    override func viewDidLoad() {
        super.viewDidLoad()
        disPlayNameLabel.text = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("profileInfo").document(uid!)
        SVProgressHUD.show(withStatus: "Loading...")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                SVProgressHUD.dismiss()
                
                self.settingsdata = dataDescription!
                self.tableView.reloadData()
            } else {
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: "Document does not exist")
                
                print("Document does not exist")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        if settingsdata.count == 1{
            cell.textLabel?.text = "Sorry No Data Available Now"
        }
        else{
            cell.editButtonPressed.tag = indexPath.row
            cell.editButtonPressed.addTarget(self, action: #selector(editButtonPres(_:)), for: .touchUpInside)
            cell.textLabel?.text = Array(settingsdata)[indexPath.row].key
            cell.detailTextLabel?.text = Array(settingsdata)[indexPath.row].value as? String
            // cell.textLabel?.text = settingsdata["Gender"] as! String
        }
        return cell
        
    }
    func chooseCurrentAilment(selectedAilment: String) {
        currentAilment = selectedAilment
    }
    
    func choosePhysicalyActivity(selectedphysicalActivity: String) {
        physicalActivitys = selectedphysicalActivity
    }
    
    func chooseGender(selectedGender: String) {
        gender = selectedGender
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TocurrentAilment" {
            let destination = segue.destination as! CurrentAilmentViewController
            destination.delegate = self
            
        }
        else if segue.identifier == "toPhysicalActivity" {
            let destination = segue.destination as! PhysicalyActivityViewController
            destination.delegate = self
        }
        else if segue.identifier == "toGender" {
            let destination = segue.destination as! GenderViewController
            destination.delegate = self
        }
    }
    @objc func editButtonPres(_ sender: UIButton){
        
        
        if Array(settingsdata)[sender.tag].key == "currentAilment"{
            performSegue(withIdentifier: "TocurrentAilment", sender: self)
        }
        else if Array(settingsdata)[sender.tag].key == "physicalActivity"{
            performSegue(withIdentifier: "toPhysicalActivity", sender: self)
        }
        else if Array(settingsdata)[sender.tag].key == "Gender"{
            performSegue(withIdentifier: "ToGender", sender: self)
        }
            
        else {
            let alertVC = UIAlertController(title: Array(settingsdata)[sender.tag].key, message: "Put your \(Array(settingsdata)[sender.tag].key)", preferredStyle: .alert)
            alertVC.addTextField { (textfield) in
                //            settingsdata.updateValue(textfield.text, forKey: Array(settingsdata)[sender.tag].key)
                
            }
            let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
                if let input = alertVC.textFields?[0]{
                    self.settingsdata.updateValue(input.text!, forKey: Array(self.settingsdata)[sender.tag].key)
                    
                    
                    let docRef = self.db.collection("profileInfo").document(self.uid!)
                    SVProgressHUD.show(withStatus: "Loading...")
                    // Set the "capital" field of the city 'DC'
                    docRef.updateData([
                        Array(self.settingsdata)[sender.tag].key: input.text!
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                            SVProgressHUD.dismiss()
                            SVProgressHUD.showError(withStatus: err.localizedDescription)
                        } else {
                            self.tableView.reloadData()
                            SVProgressHUD.dismiss()
                            SVProgressHUD.showSuccess(withStatus: "Updated successfully")
                        }
                    }
                    
                }
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(okButton)
            alertVC.addAction(cancelButton)
            
            present(alertVC,animated: true)
            
        }
        
        
        
        
        print(Array(settingsdata)[sender.tag].key)
    }
    @IBAction func logoutButton(_ sender:UIButton){
        
        if (Auth.auth().currentUser?.uid) != nil{
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "BackToSignin", sender: nil)
            }
            catch let err {
                print(err.localizedDescription)
            }
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

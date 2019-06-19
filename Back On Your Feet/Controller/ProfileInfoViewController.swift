//
//  ProfileInfoViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 23/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class ProfileInfoViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var currentAilment:String?
    var preferedFood:String?
    var physicalActivitys:String?
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil

    @IBOutlet weak var ageTextField: UITextField!
    var myPickerView : UIDatePicker!
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAge()
    
        
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        nextButtonClicked()
    }
    
    func nextButtonClicked(){
        
        if db.collection("profileInfo").document().documentID.hashValue != 0{
            let userid = Auth.auth().currentUser?.uid

            if currentAilment != nil,physicalActivitys != nil,preferedFood != nil{
                self.db.collection("profileInfo").document(userid!).setData( [
                    "currentAilment": currentAilment ?? "",
                    "physicalActivity": physicalActivitys ?? "",
                    "preferredFood": preferedFood ?? ""
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        self.performSegue(withIdentifier: "moveNext", sender: nil)
                        print("Document added with ")
                    }
                }
            }
            else{
                alertController(for: "Error", with: "Please fill all details")
            }
            
            
        }
        else {
            let userid = Auth.auth().currentUser?.uid
            db.collection("profileInfo").document(userid!).setData( [
                "currentAilment": currentAilment ?? "",
                "physicalActivity": physicalActivitys ?? "",
                "preferredFood": preferedFood ?? ""
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    self.performSegue(withIdentifier: "moveNext", sender: nil)
                    print("Document added with ")
                }
            }
        }

        
        
       
    }
    
    
    
    
    @IBAction func currentAilment(_ sender: UIButton) {
        
       getOthersInfoDetails(with: "Current Alignment", message: "Enter lignment Details")
    }
    @IBAction func physicalActivity(_ sender: UIButton) {
        getOthersInfoDetails(with: "Physical Activity", message: "Enter Physicl activity")
    }
    @IBAction func preferredFood(_ sender: UIButton) {
        getOthersInfoDetails(with: "Preffered Food", message: "Enter Prefered Food Details")
    }
    @IBAction func gender(_ sender: UIButton) {
        
    }
    
    private func getOthersInfoDetails(with title:String,message:String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.view.backgroundColor = #colorLiteral(red: 0.1997678876, green: 0.4631895423, blue: 0.615168035, alpha: 1)
        alertVC.addTextField { (aligmentTextFiled) in
            aligmentTextFiled.placeholder = "Enter \(title) Details...."
        }
        let doneButton = UIAlertAction(title: "Add", style: .default) { (_) in
            if let input = alertVC.textFields![0].text{
                if title == "Current Alignment"{
                    
                    self.currentAilment = input
                }
                else if title == "Physical Activity"{
                    self.physicalActivitys  = input
                }
                else if title == "Preffered Food"{
                    self.preferedFood = input
                }
            }
            
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancelButton)
        alertVC.addAction(doneButton)
        
        present(alertVC,animated: true,completion: nil)
    }

    private func getAge(){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(onDatePickerValueChanged), for: UIControl.Event.valueChanged)
        ageTextField.inputView = datePickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePickerPressed))
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        ageTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneDatePickerPressed(){
        self.view.endEditing(true)
    }
    
    @objc func onDatePickerValueChanged(datePicker: UIDatePicker) {
        self.ageTextField.text = dateFormatter.string(from: datePicker.date)
    }
}

extension ProfileInfoViewController{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}



extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}

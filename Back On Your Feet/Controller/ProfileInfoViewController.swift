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
extension ProfileInfoViewController:currentAilmentDelegate,PhysicalyActivityDelegate,GenderDelegate{
    func chooseGender(selectedGender: String) {
        gender = selectedGender
    }
    
    func choosePhysicalyActivity(selectedphysicalActivity: String) {
        physicalActivitys = selectedphysicalActivity
    }
    
    func chooseCurrentAilment(selectedAilment: String) {
        currentAilment = selectedAilment
    }
}
class ProfileInfoViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
 
    var currentAilment:String?
    var gender:String?
    var physicalActivitys:String?
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    @IBOutlet weak var currentAilmentButton: UIButton!
        @IBOutlet weak var physicalActivityButton: UIButton!
        @IBOutlet weak var GenderButton: UIButton!
        //@IBOutlet weak var PrefferedFoodButton: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    var myPickerView : UIDatePicker!
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAge()
        physicalActivityButton.isHidden = true
        weightTextField.isHidden = true
        GenderButton.isHidden = true
        heightTextField.isHidden = true
        currentAilmentButton.isHidden = true

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
        if currentAilment == "Bone/Joints"{
            physicalActivityButton.isHidden = false
        }
        if gender != nil{
            currentAilmentButton.isHidden = false
        }
        
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
    @IBAction func nextButton(_ sender: Any) {
        print(currentAilment ?? "")

        nextButtonClicked()
    }
    
    func nextButtonClicked(){
        
        if db.collection("profileInfo").document().documentID.hashValue != 0{
            let userid = Auth.auth().currentUser?.uid

            if currentAilment != nil,heightTextField.text != nil,weightTextField.text != nil,ageTextField.text != nil{
                
                self.db.collection("profileInfo").document(userid!).setData( [
                    "currentAilment": currentAilment ?? "",
                    "Gender": gender ?? "",
                    "height":heightTextField.text!,
                    "weightTextField":weightTextField.text!,
                    "Age":calcAge(birthday: ageTextField.text!)
                   // "preferredFood": preferedFood ?? ""
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        self.ShowAlert(title: "Error", message: err.localizedDescription)
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
                "Gender": gender ?? ""
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
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    
    @IBAction func currentAilment(_ sender: UIButton) {
        performSegue(withIdentifier: "TocurrentAilment", sender: self)
      // getOthersInfoDetails(with: "Current Alignment", message: "Enter lignment Details")
    }
    @IBAction func physicalActivity(_ sender: UIButton) {
        //toPhysicalActivity
        performSegue(withIdentifier: "toPhysicalActivity", sender: self)

       // getOthersInfoDetails(with: "Physical Activity", message: "Enter Physicl activity")
    }
    @IBAction func preferredFood(_ sender: UIButton) {
        //getOthersInfoDetails(with: "Preffered Food", message: "Enter Prefered Food Details")
    }
    @IBAction func gender(_ sender: UIButton) {
        performSegue(withIdentifier: "toGender", sender: self)
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
        if ageTextField.text != "" && ageTextField.text != "Age"{
            weightTextField.isHidden = false
        }
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
        if weightTextField.text != "" && weightTextField.text != "Weight in Kg"{
            heightTextField.isHidden = false
        }
        if heightTextField.text != "" && heightTextField.text != "Height"{
            GenderButton.isHidden = false
        }
    }
    
    
    
    
    
//    private func getOthersInfoDetails(with title:String,message:String){
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.view.backgroundColor = #colorLiteral(red: 0.1997678876, green: 0.4631895423, blue: 0.615168035, alpha: 1)
//        alertVC.addTextField { (aligmentTextFiled) in
//            aligmentTextFiled.placeholder = "Enter \(title) Details...."
//        }
//        let doneButton = UIAlertAction(title: "Add", style: .default) { (_) in
//            if let input = alertVC.textFields![0].text{
//                if title == "Current Alignment"{
//
//                    self.currentAilment = input
//                }
//                else if title == "Physical Activity"{
//                    self.physicalActivitys  = input
//                }
//                else if title == "Preffered Food"{
//                    self.preferedFood = input
//                }
//            }
//
//        }
//        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertVC.addAction(cancelButton)
//        alertVC.addAction(doneButton)
//
//        present(alertVC,animated: true,completion: nil)
//    }

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

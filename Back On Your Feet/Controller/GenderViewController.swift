//
//  GenderViewController.swift
//  Back On Your Feet
//
//  Created by GenderViewController Muhammad Abdullah on 21/06/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//
//
//  GenderViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 19/06/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

protocol GenderDelegate:class {
    func chooseGender(selectedGender:String)
}

class GenderViewController: UIViewController {
    var dataArray = ["Male","Female","Others"]
    var selectedData:String = String()
    weak var delegate:GenderDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        if selectedData.isEmpty{
            print("popppppp")
            ShowAlert(title: "Error", message: "Please select an option")
        }
        else{
            
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            print("Pop")
            // presentingViewController?.dismiss(animated: false, completion: nil)
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
extension GenderViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Avenir", size: 24)
        tableView.layer.cornerRadius = 10.0
        tableView.layer.masksToBounds = true
        tableView.separatorColor = #colorLiteral(red: 0.2016202807, green: 0.463247776, blue: 0.6151759624, alpha: 1)
        if selectedData.contains(dataArray[indexPath.row]) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedData.contains(dataArray[indexPath.row]) {
            selectedData.removeLast()
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            selectedData.removeAll()
            selectedData.append(dataArray[indexPath.row])
            delegate?.chooseGender(selectedGender: selectedData)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}

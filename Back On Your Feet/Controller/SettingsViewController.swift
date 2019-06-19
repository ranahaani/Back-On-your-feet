//
//  SettingsViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 04/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
         return 3
        }
        else if section == 1{
            return 2
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
            cell.textLabel?.text = "Preffered food"
            if indexPath.row == 2{
                cell.textLabel?.text = "Feedback"
            }
            return cell
        
    }
    
    @IBAction func logoutButton(_ sender:UIButton){
        if let id = Auth.auth().currentUser?.uid{
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
